module LucianKaminari
  module Generators
    class ConfigTwoGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc <<DESC
Description:
  copy lucian_kaminari configuration to your application config initializer folder.
DESC

      def copy_config_file
        template 'kaminari_config.rb', 'config/initializers/kaminari_config.rb'
      end
    end
  end
end