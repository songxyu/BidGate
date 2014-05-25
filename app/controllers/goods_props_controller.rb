class GoodsPropsController < ApplicationController
  include CategoriesHelper
  
  def new
  end

  def index
    @goods_props = GoodsProp.all

    @goods_props.each do |prop|
      prop.goods_prop_values = GoodsPropValue.where(goods_prop_id: prop.id)
    end
  end

  def props_by_category
     category_id = params[:category_id]
    # @goods_props = GoodsProp.joins(:goods_prop_values).where('goods_prop_values.category_id' => category_id)
    # # TODO: how to return only the match associations?
   

    @goods_props = CategoriesHelper.get_dyn_props_by_category(category_id)
    logger.debug '@goods_props: ' +  @goods_props.to_s
    
    respond_to do |format|
      format.js { render :layout=> false  }
    end
  end
end