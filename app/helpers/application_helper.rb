module ApplicationHelper
  extend self

  def parse_something(string)
    # do stuff here
  end

  def other_utility_method(number, string)
    # do some more stuff
  end
  
  
  def display_notice_and_alert
    msg = ''
    msg << (content_tag :div, notice, :class => "notice") if notice
    msg << (content_tag :div, alert, :class => "alert") if alert
    sanitize msg
  end
  
  
  def get_breadcrumb_path_info (path_key)
    pathKeyArr = path_key.split(',')
    path_info = []
    pathKeyArr.each do |pathKey|
      case pathKey
      when 'dashboard' then path_info.push(['我的控制台', './dashboard/dashboard'])
      when 'homepage' then path_info.push(['首页', './'])
      when 'detail' then path_info.push(['订单详情', './orders/'])
      when 'filter' then path_info.push(['订单搜索', './orders/search?search'])
      else path_info.push(['首页', './'])
      end
    end
    
    Rails.logger.debug "get_breadcrumb_path_info: " + path_info.to_s
    
    return path_info
  end
  
end
