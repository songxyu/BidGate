class CategoryUnit < ActiveRecord::Base
  belongs_to :category
  attr_accessible :unit_name
  
end
