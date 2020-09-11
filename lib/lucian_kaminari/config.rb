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
    attr_accessor :default_per_page, :left, :right, :page_method_name

    def initialize
      @default_per_page = 40
      @left = 1
      @right = 1
      @page_method_name = "page"
    end
  end
end