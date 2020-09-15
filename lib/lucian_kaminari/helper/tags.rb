module LucianKaminari
  module Helpers
    PARAM_KEY_EXCEPT_LIST = [:authenticity_token, :commit, :utf8, :_method, :script_name, :original_script_name].freeze

    class Tag
      def initialize(template, params = {}, param_name = nil, **options)
        @template, @info_hash = template, options
        @param_name = param_name || LucianKaminari.config.page_method_name
        @params = template.params.except!(*PARAM_KEY_EXCEPT_LIST)
        @params.merge! params
      end

      def to_s(locals = {}) #:nodoc:
        formats = (@template.respond_to?(:formats) ? @template.formats : Array(@template.params[:format])) + [:html]
        @template.render partial: partial_path, locals: @info_hash.merge(locals), formats: formats
      end

      private

      def page_url_for(page)
        @template.url_for @params.update(@param_name => page)
      end

      def partial_path
        [
            "kaminari",
            self.class.name.demodulize.underscore
        ].compact.join("/")
      end
    end

    module Link
      # target page number
      def page
        raise 'Override page with the actual page value to be a Page.'
      end
      # the link's href
      def url
        page_url_for page
      end
      def to_s(locals = {}) #:nodoc:
        locals[:url] = url
        super locals
      end
    end

    class Page < Tag
      include Link
      # target page number
      def page
        @info_hash[:page]
      end
      def to_s(locals = {}) #:nodoc:
        locals[:page] = page
        super locals
      end
    end

    class FirstPage < Tag
      include Link
      def page
        1
      end
    end

    # Link with page number that appears at the rightmost
    class LastPage < Tag
      include Link
      def page
        @info_hash[:total_pages]
      end
    end

    # The "previous" page of the current page
    class PrevPage < Tag
      include Link

      def initialize(template, params: {}, param_name: nil, **options) #:nodoc:
        # params in Rails 5 may not be a Hash either,
        # so it must be converted to a Hash to be merged into @params
        if params && params.respond_to?(:to_unsafe_h)
          ActiveSupport::Deprecation.warn 'Explicitly passing params to helpers could be omitted.'
          params = params.to_unsafe_h
        end

        super(template, params: params, param_name: param_name, **options)
      end

      def page #:nodoc:
        @info_hash[:current_page_num] - 1
      end
    end

    class NextPage < Tag
      include Link

      def initialize(template, params: {}, param_name: nil, **options)
        if params && params.respond_to?(:to_unsafe_h)
          ActiveSupport::Deprecation.warn 'Explicitly passing params to helpers could be omitted.'
          params = params.to_unsafe_h
        end

        super(template, params: params, param_name: param_name, **options)
      end

      def page #:nodoc:
        @info_hash[:current_page_num] + 1
      end
    end

    # Non-link tag that stands for skipped pages...
    class Gap < Tag
    end
  end
end