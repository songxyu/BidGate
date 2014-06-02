class CategoriesController < ApplicationController
  include CategoriesHelper
  
  def new
  	 @Category = Category.new
  end

  def index
  	@categoriesTree = Category.where(parent_id: 0)
  	@categoriesTree.each do |parentCate|
      parentCate.child_categories = Category.where(parent_id: parentCate.id)     
    end
  end
  
  def category_list
     category_id = params[:category_id] 
     @parent_cate = Category.find(category_id)
     @cate_array = CategoriesHelper.get_categories_array(category_id, true);
     
    logger.debug 'category_list(): category_id='+category_id+', @cate_array='+@cate_array.to_s 
   
    respond_to do |format|
       format.js  #{ render :file => "categories/category_list.js.erb" } 
    end
  end
  
  
  def category_unit
     category_id = params[:category_id] 
     @category_unit = CategoriesHelper.get_category_unit(category_id);
     
     respond_to do |format|
       format.js
    end
  end

end