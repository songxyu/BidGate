module CategoriesHelper
  extend self
  
  # return all categories array, sorted by parent-child levels
  # e.g. 1 : 钢材  4 : 不锈钢  5 : 普通钢  6 : 高速钢  7 : 螺纹钢  2 : 橡胶制品  8 : 硅橡胶   9 : 乙丙胶  3 : 木材  10 : 红柳木  11 : 美国红桃木
  def get_all_categories
    return get_categories_array(0, true)
  end
  
  # return array of specified category and its children , sorted by parent-child levels
  # e.g. 1 : 钢材  4 : 不锈钢  5 : 普通钢  6 : 高速钢  7 : 螺纹钢
  def get_categories_array(root_category_id, bContainChildren)
    Rails.logger.debug 'CategoriesHelper@get_categories_array(): root_category_id=' + root_category_id.to_s + ', bContainChildren='+bContainChildren.to_s
    
    cate_array = []
    categoriesRoot = Category.where(parent_id: root_category_id)
    if bContainChildren 
      categoriesRoot.each do |parentCate|
        cate_array += append_category_children_recursively(parentCate)     
      end
    else
      cate_array.concat(categoriesRoot)
    end
        
    Rails.logger.debug 'CategoriesHelper@get_categories_array(): ' + cate_array.to_s
    return cate_array
  end

  
  def get_dyn_props_by_category(category_id)
    # note: the query of relation returns an array!
    goods_props = GoodsProp.joins(:goods_prop_values).where('goods_prop_values.category_id' => category_id)
    
    # debug
    goods_props.each do |prop| 
      Rails.logger.debug 'CategoriesHelper@get_dyn_props_by_category(): prop= ' +  prop.name
    end
    
    return goods_props;
  end
  
  def get_category_unit(category_id)
    # note: the query returns an array!
    categoryUnits = CategoryUnit.where('category_id' => category_id)
    
    #debug
    categoryUnits.each do |unit| 
      Rails.logger.debug 'CategoriesHelper@get_category_unit(): unit= ' +  unit.unit_name
    end
    
    return categoryUnits[0]  
    
  end
  
  # get 6 parent categories name and first-child categories for homepage
  def get_cates_descs
    categoryDescArr = []
    categoriesRoot = Category.where(parent_id: 0).limit(6)
    categoriesRoot.each do |parentCate|
      cateInfo = []
      firstChildren = Category.where(parent_id: parentCate.id).limit(3)
      childrenNameStr = ''
      firstChildren.each do |child|
        childrenNameStr += child.name+","# remove last ,
        
      end
      
      cateInfo << parentCate.id
      cateInfo << parentCate.name
      cateInfo << childrenNameStr
      
      categoryDescArr << cateInfo

    end 
    
    return categoryDescArr
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
