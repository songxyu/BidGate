class GoodsPropsController < ApplicationController
  def new
  end

  def index
  	@goods_props = GoodsProp.all
  	
  	@goods_props.each do |prop|
  	  prop.goods_prop_values = GoodsPropValue.where(goods_prop_id: prop.id)  	  
  	end
  end
end