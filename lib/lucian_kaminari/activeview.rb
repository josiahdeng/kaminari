require 'active_support/lazy_load_hooks'

ActiveSupport.on_load :action_view do
  require 'lucian_kaminari/helper/page_helper'
  ::ActionView::Base.send :include, LucianKaminari::Helpers::PageHelper
end