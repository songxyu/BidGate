class Location < ActiveRecord::Base
  attr_accessible :name, :parent_id, :zip_code
  
  has_many :child_locations, class_name: "Location", foreign_key: "parent_id" # foreign key must be specified in has_many!
  belongs_to :parent_location, class_name: "Location"
  
  # must define parent_location, as belongs_to will not auto fill it.
  def parent_location
    if self.parent_id && self.parent_id>0
      return Location.find( self.parent_id )
    else 
      return nil
    end
  end
  
  
  def full_location_name    
    if self.parent_location 
      p(parent_location)
      logger.debug "Current location.name=" + name + ", parent_location.name= "+parent_location.name     
      parent_location.name + " " + name 
    else
      return name
    end
     
  end
end
