require 'active_support/lazy_load_hooks'

ActiveSupport.on_load :active_record do
  require 'lucian_kaminari/core'
  require 'lucian_kaminari/model/page_model'
  ::ActiveRecord::Base.send :include, LucianKaminari::PageModel
end