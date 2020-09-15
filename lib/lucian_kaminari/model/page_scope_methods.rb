module LucianKaminari
  module PageScopeMethods
    def per(num)
      limit(num).offset(offset_value / limit_value * num)
    end

    #当前页
    def current_page
      (offset_value/limit_value) + 1
    end

    #总页数
    def total_pages
      #保留小数，向上取整
      (total_count.to_f / limit_value).ceil
    end
  end
end