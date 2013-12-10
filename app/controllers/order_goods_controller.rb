class OrderGoodsController < ApplicationController
  def index
    @order = Order.find(params[:order_id])
    @order_goods = @order.order_goods 
  end
  
  def show
    @order = Order.find(params[:order_id])
    @one_order_goods = @order.order_goods.find(params[:id])
   # @one_order_goods.goods_exts = GoodsExt.where(order_goods_id: @one_order_goods.id)
  end 
  
end
