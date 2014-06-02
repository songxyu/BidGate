class CompanyVendor < ActiveRecord::Base
  belongs_to :company
  attr_accessible :vendor_id
  
  has_many :vendors, :class_name => "Companies", dependent: :destroy
  
end
