module CategoriesHelper
  
  def get_dyn_props_by_category(category_id)
    @goods_props = GoodsProp.joins(:goods_prop_values).where('goods_prop_values.category_id' => category_id)
    # TODO: how to return only the match associations?
    
    # debug
    @goods_props.each do |prop| 
      logger.debug 'CategoriesHelper@get_dyn_props_by_category(): prop= ' +  prop.name
    end
    
  end
  
  def get_category_unit(category_id)
    @categoryUnit = CategoryUnit.where('category_id' => category_id)
  end
end
