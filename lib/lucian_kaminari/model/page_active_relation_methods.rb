module LucianKaminari
  module PageActiveRelationMethods

    #获得总数
    def total_count
      c = except(:limit, :offset, :order)
      c.count("*")
    end
  end
end