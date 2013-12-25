class OrdersController < ApplicationController
  
  def index
    param_cate_id = params[:category_id] 
    order_id_list = params[:order_id_list]
    @filter_tag_name = params[:tag_name]
    @filter_category = param_cate_id ? Category.where(id: param_cate_id)[0] : nil
    
    if param_cate_id
      @orders = Order.where(category_id: param_cate_id)
    elsif order_id_list
      @orders = Order.find(order_id_list)      
    else
      @orders = Order.all
    end
    
    #@orders.each do |oneOrder|
      #oneOrder.order_goods = OrderGoods.where(order_id: oneOrder.id)
      #oneOrder.order_price_histories = OrderPriceHistory.where(order_id: oneOrder.id)
      #oneOrder.seller = User.find( oneOrder.seller_id ) # no need do this!
      #oneOrder.buyer = User.find( oneOrder.buyer_id )
    #end
  end
  
  def new
    @order = Order.new
    @category = Category.where(parent_id: 0)
  end
  
  def create
    # These params are obsolete:
=begin   
    category:4
    order_goods[name]:不锈钢啊
    order_goods[model]:1111
    order_goods[price]:600.0
    order_goods[quantity]:10
    price:6000.0
    order[price_type]:0
    deadline[year]:2013
    deadline[month]:12
    deadline[day]:16
    deadline[hour]:00
    deadline[minute]:00  
=end   
    
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
      price: params[:order][:price], buyer_id: nil, seller_id: session[:user_id], price_type: params[:order][:price_type], 
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
  
  
  def order_detail_params
    params.require(:order).permit(:deadline, :price, :price_type, 
      order_goods_attributes: [:name, :model, :price, :quantity, :_destroy]) # when remove, need _destroy
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
