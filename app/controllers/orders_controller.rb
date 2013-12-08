class OrdersController < ApplicationController
  
  def index
    
    @orders = Order.all
    @orders.each do |oneOrder|
      oneOrder.order_goods = OrderGoods.where(order_id: oneOrder.id)
      oneOrder.order_price_histories = OrderPriceHistory.where(order_id: oneOrder.id)
    end
  end
end
