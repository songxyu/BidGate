class OrderGoodsController < ApplicationController
  include ResponseUtil
  
  
  def index
    @order = Order.find(params[:order_id])
    @order_goods = @order.order_goods 
    
    ResponseUtil.common_response
  end
  
  def show
    @order = Order.find(params[:order_id])
    @one_order_goods = @order.order_goods.find(params[:id])
   # @one_order_goods.goods_exts = GoodsExt.where(order_goods_id: @one_order_goods.id)
   
   ResponseUtil.common_response
  end 
  
  
end
