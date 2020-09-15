module LucianKaminari
  class << self
    def configuration
      yield config
    end

    def config
      @l_config = Configuration.new
    end
  end

  class Configuration
    #初始化配置
    attr_accessor :default_per_page, :left, :right, :page_method_name, :window

    def initialize
      @default_per_page = 4
      @left = 1
      @right = 1
      @page_method_name = "page"
      @window = 2
    end
  end
end