module LucianKaminari
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/views', __FILE__)

      def copy_entry
        directory "kaminari", "app/views/kaminari"
      end
    end
  end
end