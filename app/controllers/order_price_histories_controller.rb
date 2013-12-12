class OrderPriceHistoriesController < ApplicationController
  
  def index
    @order = Order.find(params[:order_id])
    @price_histories = @order.order_price_histories 
  end 
  
  def show
    @order = Order.find(params[:order_id])
    @price_history = @order.order_price_histories.find(params[:id])
  end

  def edit
  	@order = Order.find(params[:order_id])
  	@price_history = @order.order_price_histories.find(params[:id])
  end

  def new
  	@price_history = @order.order_price_histories.find(params[:order_id])
  end

  def create
   
  	@price_history = OrderPriceHistory.new(order_id: params[:order_id], price: params[:bid_price], buyer_id:1, bid_time: DateTime.current() )
  	@price_history.save
    redirect_to order_order_price_history_path(:order_id => @price_history.order_id, :id=>@price_history.id)
  end

end
