module CategoriesHelper
  extend self
  
  # return all categories array, sorted by parent-child levels
  # e.g. 1 : 钢材  4 : 不锈钢  5 : 普通钢  6 : 高速钢  7 : 螺纹钢  2 : 橡胶制品  8 : 硅橡胶   9 : 乙丙胶  3 : 木材  10 : 红柳木  11 : 美国红桃木
  def get_all_categories
    return get_categories_array(0)
  end
  
  # return array of specified category and its children , sorted by parent-child levels
  # e.g. 1 : 钢材  4 : 不锈钢  5 : 普通钢  6 : 高速钢  7 : 螺纹钢
  def get_categories_array(root_category_id)
    cate_array = []
    categoriesRoot = Category.where(parent_id: root_category_id)
    categoriesRoot.each do |parentCate|
      cate_array += append_category_children_recursively(parentCate)     
    end
    
    # logger.debug 'CategoriesHelper@get_categories_array(): ' + cate_array.to_s
    return cate_array
  end

  
  def get_dyn_props_by_category(category_id)
    goods_props = GoodsProp.joins(:goods_prop_values).where('goods_prop_values.category_id' => category_id)
    # TODO: how to return only the match associations?
    
    # debug
    goods_props.each do |prop| 
      logger.debug 'CategoriesHelper@get_dyn_props_by_category(): prop= ' +  prop.name
    end
    
    return goods_props;
  end
  
  def get_category_unit(category_id)
    @categoryUnit = CategoryUnit.where('category_id' => category_id)
  end
  
   
    
  private
  def append_category_children_recursively(parentCate)
    arr = []
    arr << parentCate
    
    parentCate.child_categories = Category.where(parent_id: parentCate.id) 
    parentCate.child_categories.each do |child|      
      arr += append_category_children_recursively(child)     
    end
     
    return arr
  end
end
