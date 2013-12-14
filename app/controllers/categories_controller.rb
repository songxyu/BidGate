class CategoriesController < ApplicationController
  def new
  	 @Category = Category.new
  end

  def index
  	@categoriesTree = Category.where(parent_id: 0)
  	@categoriesTree.each do |parentCate|
      parentCate.child_categories = Category.where(parent_id: parentCate.id)     
    end
  end
  

end