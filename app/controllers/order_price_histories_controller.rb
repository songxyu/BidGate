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
    orderId = params[:order_id]
    vendorId = session[:user_id]

    condition = " order_price_histories.order_id = " + orderId + " and order_price_histories.vendor_id = " + vendorId.to_s

    OrderPriceHistory.update_all('is_valid = 0', condition)

  	@price_history = OrderPriceHistory.new(order_id: orderId, price: params[:bid_price], vendor_id: vendorId ,
          bid_time: DateTime.current(), bid_memo: params[:bid_memo], delivery_days: params[:delivery_days], is_valid: true )
  	@price_history.save

    redirect_path = params[:redirect_path]
    logger.debug 'order_price_histories.create() : redirect_path= ' + redirect_path
    if  redirect_path
       # redirect_to "/dashboard/dashboard_vendings"
      rediPath = (redirect_path[0] =='/' ? '': '/') + redirect_path.gsub('@@', '/')
      logger.debug ' rediPath = '+ rediPath

      redirect_to rediPath # to the action
    else
      redirect_to order_order_price_history_path(:order_id => @price_history.order_id, :id=>@price_history.id)
    end
  end
 

end
