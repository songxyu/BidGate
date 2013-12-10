class OrdersController < ApplicationController
  
  def index
    
    @orders = Order.all
    @orders.each do |oneOrder|
      oneOrder.order_goods = OrderGoods.where(order_id: oneOrder.id)
      oneOrder.order_price_histories = OrderPriceHistory.where(order_id: oneOrder.id)
      #oneOrder.seller = User.find( oneOrder.seller_id ) # no need do this!
      #oneOrder.buyer = User.find( oneOrder.buyer_id )
    end
  end
  
  def show
    @order = Order.find(params[:id])
    #@order.seller = User.find( @order.seller_id )  # no need do this!
    #@order.buyer = User.find( @order.buyer_id )
  end
  
  def edit
    @order = Order.find(params[:id])
  end
end
