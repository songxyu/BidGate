class Location < ActiveRecord::Base
  attr_accessible :name, :parent_id, :zip_code
  
  has_many :child_locations, class_name: "Location", foreign_key: "parent_id" # foreign key must be specified in has_many!
  belongs_to :parent_location, class_name: "Location"
end
