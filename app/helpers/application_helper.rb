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
    msg << content_tag(:div, content_tag(:i, "", :class => "glyphicon glyphicon glyphicon-ok span-icon")+ notice, :class => "alert alert-success") if notice
    msg << content_tag(:div, content_tag(:span, "提示!", :class => "alert-warning-info")+ alert,
         :class => "alert alert-warning") if alert
    sanitize msg
  end

  def get_breadcrumb_path_info (path_key)
    if !path_key
    return []
    end

    pathKeyArr = path_key.split(',')
    path_info = []
    pathKeyArr.each do |pathKey|
      case pathKey
      when 'homepage' then path_info.push(['首页', './'])
      when 'createOrder' then path_info.push(['创建采购单', './order_new'])
      when 'detail' then path_info.push(['订单详情', './orders/'])
      when 'filter' then path_info.push(['订单搜索', './orders/search?breadcrumb_path_key=homepage,filter&search='])
      when 'dashboard' then path_info.push(['我的壹百万', './dashboard/dashboard?breadcrumb_path_key=homepage,dashboard'])
      when 'myPurchase' then path_info.push(['采购单管理', './dashboard/dashboard_purchases'])
      when 'myVending' then path_info.push(['竞价单管理', './dashboard/dashboard_vendings'])
      when 'myMessage' then path_info.push(['消息管理', './dashboard/dashboard_msg'])
      when 'mySetting' then path_info.push(['设置', './dashboard/dashboard_settings'])
      else path_info.push(['首页', './'])
      end
    end

    Rails.logger.debug "get_breadcrumb_path_info: " + path_info.to_s

    return path_info
  end

end
