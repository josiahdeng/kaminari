require 'active_support/inflector'
require 'lucian_kaminari/helper/tags'

module LucianKaminari
  module Helpers
    class Paginator < Tag
      def initialize(template , **options)
        @template, @info_hash = template, options
        @windows_infos = @info_hash.merge({window: LucianKaminari.config.window})
        @windows_infos[:current_page] = @info_hash[:current_page] = PageProxy.new(@windows_infos, @info_hash[:current_page_num])
        @output_buffer = ::ActionView::OutputBuffer.new
      end

      def to_s
        super @windows_infos.merge paginator: self
      end

      def render(&block)
        instance_eval(&block) if @info_hash[:total_pages] > 1
        @output_buffer.presence
      end

      def each_relevant_page
        return to_enum(:each_relevant_page) unless block_given?

        relevant_pages(@windows_infos).each do |page|
          yield PageProxy.new(@windows_infos, page)
        end
      end
      alias each_page each_relevant_page

      def relevant_pages(infos)
        #取左右两边间距为2以内的页码
        #左边页码
        left_page_num = [*(infos[:current_page_num] - LucianKaminari.config.window)...infos[:current_page_num]]
        #右边页码
        right_range = (r_page= infos[:current_page_num] + LucianKaminari.config.window) > infos[:total_pages] ? infos[:total_pages] : r_page
        right_page_num = [*(infos[:current_page_num]..right_range)]
        left_page_num.concat(right_page_num).uniq.reject{|page_num| page_num < 0}
      end

      %w[first_page prev_page next_page last_page gap].each do |tag|
        eval <<-DEF, nil, __FILE__, __LINE__ + 1
          def #{tag}_tag
            #{tag.classify}.new @template, **@info_hash
          end
        DEF
      end

      def method_missing(name, *args, &block)
        @template.respond_to?(name) ? @template.send(name, *args, &block) : super
      end

      def page_tag(page)
        Page.new @template, **@info_hash.merge(page: page)
      end
    end

    class PageProxy
      include Comparable
      def initialize(options, page)
        @options, @page = options, page
      end

      def number
        @page
      end

      def current?
        @page == @options[:current_page_num]
      end

      def first?
        @page == 1
      end

      def last?
        @page == @options[:total_pages]
      end

      # the previous page or not
      def prev?
        @page == @options[:current_page_num] - 1
      end

      # the next page or not
      def next?
        @page == @options[:current_page_num] + 1
      end

      def rel
        if next?
          'next'
        elsif prev?
          'prev'
        end
      end

      def out_of_range?
        @page > @options[:total_pages]
      end

      def to_i #:nodoc:
        number
      end

      def to_s #:nodoc:
        number.to_s
      end

      def +(other) #:nodoc:
        to_i + other.to_i
      end

      def -(other) #:nodoc:
        to_i - other.to_i
      end

      def <=>(other) #:nodoc:
        to_i <=> other.to_i
      end
    end
  end
end