class OrdersController < ApplicationController
  include ResponseUtil
  
  # TODO: fix issue using after_filter: Render and/or redirect were called multiple times in this action. Please note that you may only call render OR redirect, and at most once per action.
  #after_filter :common_response,  :only => [:show, :edit]  #:except => [:create, :update, :delete], 
    
  
  def index
    param_cate_id = params[:category_id] 
    order_id_list = params[:order_id_list]
    @filter_tag_name = params[:tag_name]
    @filter_category = param_cate_id ? Category.where(id: param_cate_id)[0] : nil
    
    visible_order_status = [0, 1, 2]
    if param_cate_id
      @orders = Order.where(category_id: param_cate_id, status: visible_order_status).page(params[:page])
    elsif order_id_list
      @orders = Order.find(order_id_list).page(params[:page])
    else
      @orders = Order.where(status: visible_order_status).page(params[:page])
    end
    
    # no need!
    #@orders.each do |oneOrder|
      #oneOrder.order_goods = OrderGoods.where(order_id: oneOrder.id)
      #oneOrder.order_price_histories = OrderPriceHistory.where(order_id: oneOrder.id)
      #oneOrder.vendor = User.find( oneOrder.vendor_id ) # no need do this!
      #oneOrder.buyer = User.find( oneOrder.buyer_id )
    #end
 
    logger.debug "index called finished... "     
  end
  
  
  def search
     logger.debug "Search param:" + params[:search]  
     @search = Order.search do
        fulltext params[:search]  
        order_by :create_time, :desc
        paginate :page => params[:page], :per_page => 2
     end
     @orders = @search.results
     
     logger.debug "Search result count: " + @orders.count.to_s
     render "index"  
  end
  
  def new
    @order = Order.new
    @category = Category.where(parent_id: 0)
    ResponseUtil.common_response
  end
  
  def create 
    # new param list:
=begin    
    {"utf8"=>"✓",
     "authenticity_token"=>"tTolOrDsZGyImStWzUWlea+aCObGZ4WTS5iKcIXSBss=",
     "parent_category"=>"3",
     "category"=>"10",
     "order"=>{
       "order_goods_attributes"=>{
         "0"=>{"name"=>"1",
               "model"=>"1",
               "price"=>"1",
               "quantity"=>"1",
               "_destroy"=>"false"},
         "1387295983613"=>{"name"=>"2",
               "model"=>"2",
               "price"=>"2",
               "quantity"=>"2",
               "_destroy"=>"false"}
        },
     "price"=>"222",
     "price_type"=>"1",
     "deadline"=>"2013-12-20"
     }}
=end

    #@parent_category = Category.find(params[:parent_category])    
    cateId = params[:category]
    cateId = cateId ? cateId : params[:parent_category]
    @category = Category.find(cateId)
    
    @order = Order.new(create_time: DateTime.current, deadline: params[:order][:deadline],
      price: params[:order][:price], buyer_id: session[:user_id], vendor_id: nil, price_type: params[:order][:price_type], 
      status: 1, category_id: @category.id)
    
    arrOrderGoods = []
    filledOrderGoods = params[:order][:order_goods_attributes] #params[:order_goods];
    filledOrderGoods.each do |key, valueArr|
      puts valueArr
      valueArr['category'] = @category.name
      valueArr.delete("_destroy") # remove the unused field "_destroy", added by nested-form gem
      arrOrderGoods << valueArr
    end
    
    #puts arrOrderGoods
    @order.order_goods.build(arrOrderGoods) 
        
    @order.save       
    redirect_to @order
  end
  

  
  def show
    @order = Order.find(params[:id])
     # no need do this!
    #@order.vendor = User.find( @order.vendor_id )
    #@order.buyer = User.find( @order.buyer_id )
    ResponseUtil.common_response  
  end
  
  def edit
    @order = Order.find(params[:id])
    ResponseUtil.common_response
  end
    
    
  def order_detail_params
    params.require(:order).permit(:deadline, :price, :price_type, 
      order_goods_attributes: [:name, :model, :price, :quantity, :_destroy]) # when remove, need _destroy
  end
end
