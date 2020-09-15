module LucianKaminari
  module Helpers
    module PageHelper
      def page_view(scope, paginator_class: LucianKaminari::Helpers::Paginator, template: nil, **options)
        template ||= self
        options[:total_pages] ||= scope.total_pages
        options.reverse_merge! current_page_num: scope.current_page, remote: false
        page_view = paginator_class.new(template, **options)
        page_view.to_s
      end
    end
  end
end