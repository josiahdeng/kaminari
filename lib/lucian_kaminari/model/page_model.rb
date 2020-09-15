require 'lucian_kaminari/model/page_scope_methods'
require 'lucian_kaminari/model/page_active_relation_methods'

module LucianKaminari
  module PageModel
    extend ActiveSupport::Concern

    module ClassMethods
      def inherited(kls)
        super
        if kls.superclass == ::ActiveRecord::Base
              eval <<-RUBY, nil, __FILE__, __LINE__ + 1
          def self.#{LucianKaminari.config.page_method_name}(num = nil)
            per_page = LucianKaminari.config.default_per_page
            limit(per_page).offset(per_page * ((num = num.to_i - 1) < 0 ? 0 : num)).extending do
                include LucianKaminari::PageScopeMethods
                include LucianKaminari::PageActiveRelationMethods
            end
          end
          RUBY
        end
      end
    end

    included do
    end
  end
end