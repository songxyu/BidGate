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
    # category:4
    # order_goods[name]:不锈钢啊
    # order_goods[model]:1111
    # order_goods[price]:600.0
    # order_goods[quantity]:10
    # price:6000.0
    # order[price_type]:0
    # deadline[year]:2013
    # deadline[month]:12
    # deadline[day]:16
    # deadline[hour]:00
    # deadline[minute]:00
    
    #@parent_category = Category.find(params[:parent_category])    
    cateId = params[:category]
    cateId = cateId ? cateId : params[:parent_category]
    @category = Category.find(cateId)
    
    @order = Order.new(create_time: DateTime.current, deadline: params[:order][:deadline],
      price: params[:order][:price], buyer_id: 1, seller_id: 2, price_type: params[:order][:price_type], 
      status: 1, category_id: @category.id)
    
    filledOrderGoods = params[:order_goods];
    filledOrderGoods['category'] = @category.name
    @order.order_goods.build(filledOrderGoods)  
        
    @order.save    
    
    redirect_to @order
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
