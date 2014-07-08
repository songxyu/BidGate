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
end
