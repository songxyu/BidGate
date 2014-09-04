module OrdersHelper
  extend self

  Default_Order_By = "create_time DESC"
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

  # for order list on home page
  def get_bid_status_text(bid_status)
    case bid_status
    when 0,1 then ""
    when 2 then "成功竞拍" #已成交
    when 3 then "已完成"
    when -1 then "已取消"
    when -2 then "已过期"
    else ""
    end
  end

  # for order list on dashboard pages
  def get_order_status_text(order_status)
    case order_status
    when 0 then "新建"
    when 1 then "竞价中"
    when 2 then "待付款"
    when 3 then "已完成"
    when -1 then "已取消"
    when -2 then "已过期"
    else ""
    end
  end

  def get_all_status
    return [["新建", 0], ["竞价中", 1], ["已成交", 2], ["已完成", 3], ["已取消", -1], ["已过期 ", -2] ]
  end

  def get_sortby_criteria
    return [['订单日期', 1], ['截止日期', 2], ['价格(低-, >高)', 3], ['价格(高->低)', 4], ['数量(少->多)', 5], ['数量(多->少)', 6] ]
  end
  
  
  def get_payment_method(method_id)
    all_methods = ['担保支付', '押金', '押金+尾气款']
  
    case method_id
    when 1 then all_methods[0]
    when 2 then all_methods[1]
    when 3 then all_methods[2]
    else all_methods
    end
  end

  def get_order_deposit_by_total(total_money)
    if !total_money || total_money == ''
    total_money = 0
    end
    return total_money * 0.2
  end

  # get lastest bid price
  def get_order_lastest_bid_price(order)
    bid_history_count = order.order_price_histories.count
    bid_price = order.order_price_histories[bid_history_count-1] ? 
        order.order_price_histories[bid_history_count-1].price : ""
    return bid_price
  end
  
  # get lastest bid company name
  def get_order_lastest_bid_company(order)
    bid_history_count = order.order_price_histories.count
    return bid_history_count != 0 ? 
        order.order_price_histories[bid_history_count-1].vendor.company.name : ""
  end
  
  # get lastest bid company id
  def get_order_lastest_vendor_id(order)
    bid_history_count = order.order_price_histories.count
    return bid_history_count != 0 ? 
        order.order_price_histories[bid_history_count-1].vendor.company_id : ""
  end
  
  # get the count of bid history
  def get_bid_count(order)
    return order.order_price_histories.count
  end

  # get user role
  def get_user_role(role_id)
    case role_id
    when 0 then "未指定"
    when 1 then "采购员"
    when 2 then "销售员"
    when 3 then "销售经理"
    when 4 then "采购经理"
    end
  end
  # orders I placed for purchase
  def my_purchases( user_id , status, page_info )
    if ( !status && status != 0 )  || status == ''
      @orders = Order.where(buyer_id: user_id).order(OrdersHelper::Default_Order_By).page(page_info)
    else
      if status == 1
        # do not break this where clause! 采购商的竞价中的订单列表, 以竞价的最新时间排序!
        @orders = Order.select(' "orders".id, "orders".*, "order_price_histories".bid_time as bid_time, "orders".create_time as create_time ')
        .joins(' LEFT JOIN "order_price_histories" ON "order_price_histories"."order_id" = "orders"."id" and "order_price_histories".bid_time = (select max(bid_time) from order_price_histories  where order_id = "orders".id  ) ')
        .where(' "orders".buyer_id=? and "orders".status = 1 ', user_id).order('bid_time DESC, create_time DESC').page(page_info)
      else
        @orders = Order.where(buyer_id: user_id, status: status.to_i).order(OrdersHelper::Default_Order_By).page(page_info)
      end
    end
  end
  
  # get count of bidding, complete, forpaid status of purchase order
  def get_purchase_orders_total_count_by_status(user_id, status)
     @order_count = Order.where(buyer_id: user_id, status: status.to_i).count
  end
  
  # get count of bidding, complete, forpaid status of vending order
  def get_vending_orders_total_count_by_status(user_id, status)
     @order_count = Order.where(vendor_id: user_id, status: status.to_i).count
  end

  # orders I am its vendor
  def my_vendings( user_id, status, page_info )
    if ( !status && status != 0 ) || status == ''
      #@orders = Order.where(vendor_id: user_id).order(OrdersHelper::Default_Order_By).page(page_info)
      @orders = Order.where("orders.id in (select id from orders where vendor_id =? ) \
        or orders.id in (select distinct orders.id from orders inner join order_price_histories on orders.id = order_price_histories.order_id \
        where order_price_histories.vendor_id = ? and orders.vendor_id <> ?)
      ", user_id, user_id, user_id).order(OrdersHelper::Default_Order_By).page(page_info)
    else
      @orders = Order.where(vendor_id: user_id, status: status.to_i).order(OrdersHelper::Default_Order_By).page(page_info)
    end

  end

  # all orders I participated bidding, status: 1  bidding in process
  def my_biddings( user_id, status, page_info )
    #self.my_vendings(user_id, nil, page_info)
    if ( !status && status != 0 )  || status == ''
      @orders = Order.select('distinct "orders".id, "orders".*').joins(:order_price_histories).where('order_price_histories.vendor_id' => user_id)
          .order(OrdersHelper::Default_Order_By).page(page_info)
    else
      @orders = Order.select('distinct "orders".id, "orders".*').joins(:order_price_histories).where('order_price_histories.vendor_id' => user_id,
              "orders.status" =>  status.to_i ).order(OrdersHelper::Default_Order_By).page(page_info)
    end
  end

  def my_biddings_failed( user_id, page_info )
    @orders = Order.select('distinct "orders".id, "orders".*').joins(:order_price_histories).where(
        "order_price_histories.vendor_id = :userId and ( (orders.status > 1 and orders.vendor_id <> :userId) or orders.status < 0 )",
        {userId: user_id} ).order(OrdersHelper::Default_Order_By).page(page_info)
  end
  
  #get orders count by category id
  def get_ordercount(cate_id)
    Order.where(category_id: cate_id ).count
    
  end

  #get four lastest successfully bid orders
  def get_4_last_success_bid_orders
    @orders = Order.where(status: 2).order(deal_date: :desc).limit(4)
  end
  
  # get order image by category id
  def getItemImgUrl(cate_id)
    imageResPool = {1 => true, 2 => true, 3 => true, 7 => true, 8 => true, 10 => true, 13 => true} #Hash
    if imageResPool.key?(cate_id)
    return "../img/item_categories/cate_" + cate_id.to_s + ".jpg"
    else
      return "../img/item_categories/image_default.png"
    end
  end
  
  
  def get_currency_name(currency_id)
    case order_status
      when 0 then "RMB"
      when 1 then "USD"
      when 2 then "EUR"
      else "RMB"
    end
  end

end
