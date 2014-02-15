class OrderPriceHistoriesController < CommonController
  #include ResponseUtil
  
  def index
    @order = Order.find(params[:order_id])
    @price_histories = @order.order_price_histories 
    logger.debug("OrderPriceHistoriesController.index called!")
    
    common_response
  end 
  
  def show
    @order = Order.find(params[:order_id])
    @price_history = @order.order_price_histories.find(params[:id])
    
    common_response
  end

  def edit
  	@order = Order.find(params[:order_id])
  	@price_history = @order.order_price_histories.find(params[:id])
  	
  	common_response
  end

  def new
  	@price_history = @order.order_price_histories.find(params[:order_id])
  	
  	common_response
  end


  def create   
  	@price_history = OrderPriceHistory.new(order_id: params[:order_id], price: params[:bid_price], vendor_id: session[:user_id] , bid_time: DateTime.current() )
  	@price_history.save
    redirect_to order_order_price_history_path(:order_id => @price_history.order_id, :id=>@price_history.id)
  end
 

end
