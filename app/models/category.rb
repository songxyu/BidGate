class Category < ActiveRecord::Base
  attr_accessible :is_parent, :name, :parent_id, :sort_order, :status, :image_path
  
  has_many :child_categories, class_name: "Category", foreign_key: "parent_id" # foreign key must be specified in has_many!
  belongs_to :parent_category, class_name: "Category"
  
  
  
  def self.all_categories_tree
    Category.where(parent_id: 0)
  end
  
  def self.all_child_categories
    Category.where("parent_id > 0")
  end
  
end
