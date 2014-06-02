module OrdersHelper
  extend self
  
  
  def get_bid_progress(create_time, deadline)
    bid_progres = 0
    i_create_time = create_time.to_i
    past_time = Time.now.to_i - i_create_time
    total_time =  deadline.to_i - i_create_time
    remaining_time =  deadline.to_i - Time.now.to_i

    Rails.logger.debug "i_create_time="+ i_create_time.to_s + ", past_time=" + past_time.to_s \
    + ", total_time=" + total_time.to_s + ", remaining_time=" + remaining_time.to_s

    if remaining_time <= 0
    bid_progres = 100
    else
    bid_progres = total_time <= 0 ? 100 : (past_time * 100.0 / total_time )
    bid_progres = (bid_progres <= 0 || bid_progres>=100) ?  100 : bid_progres;
    end

    Rails.logger.debug "OrdersHelper::get_bid_process(): bid_progres="+ bid_progres.to_s

    return bid_progres
  end

  def get_bid_status(bid_progres, status)
    if bid_progres == 100
      if status == 0 || status == 1
      return -2;
      end
    end

    return status
  end

  def get_bid_status_text(bid_status)
    case bid_status
    when 0,1 then "";
    when 2 then "成功竞拍" #已成交
    when 3 then "已完成"
    when -1 then "已取消"
    when -2 then "已过期"
    end
  end
  
  def get_all_status
    return [["新建", 0], ["竞价中", 1], ["已成交", 2], ["已完成", 3], ["已取消", -1], ["已过期 ", -2] ] 
  end
  
  def get_sortby_criteria
    return [['订单日期', 1], ['截止日期', 2], ['价格(低->高)', 3], ['价格(高->低)', 4], ['数量(少->多)', 5], ['数量(多->少)', 6] ]        
  end
  

end
