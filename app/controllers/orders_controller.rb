class OrdersController < ApplicationController
  
  def index
    param_cate_id = params[:category_id] 
    @filter_category = param_cate_id ? Category.where(id: param_cate_id)[0] : nil
    
    @orders = param_cate_id ? Order.where(category_id: param_cate_id) : Order.all
    #@orders.each do |oneOrder|
      #oneOrder.order_goods = OrderGoods.where(order_id: oneOrder.id)
      #oneOrder.order_price_histories = OrderPriceHistory.where(order_id: oneOrder.id)
      #oneOrder.seller = User.find( oneOrder.seller_id ) # no need do this!
      #oneOrder.buyer = User.find( oneOrder.buyer_id )
    #end
  end
  
  def new
    @order = Order.new
    @category = Category.all
  end
  
  def create
    @parent_category = Category.find(params[:category])
    @category = Category.find(params[:sub_category])
    
    @order = Order.new(create_time: DateTime.current, deadline: params[:deadline],
      deal_price: params[:order_price], buyer_id: 1, seller_id: 2, price_type: 1, status: 1)
    @order.order_goods.build(name: @category.name, category: @parent_category.name, 
      price: params[:order_price], model: params[:goods_model], quantity: params[:goods_quantity])  
        
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
