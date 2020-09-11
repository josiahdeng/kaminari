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
                def per(num)
                   limit(num).offset(offset_value/limit_value * num)
                end
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