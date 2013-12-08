class OrderPriceHistoriesController < ApplicationController
  
  def index
    @order = Order.find(params[:order_id])
    @price_histories = @order.order_price_histories 
  end 
  
  def show
    @order = Order.find(params[:order_id])
    @price_history = @order.order_price_histories.find(params[:id])
  end 
end
