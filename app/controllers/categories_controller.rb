class CategoriesController < ApplicationController
  def new
  	 @Category = Category.new
  end

  def index
  	@categories = Category.all
  end
end