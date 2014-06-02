class CompanyVendor < ActiveRecord::Base
  belongs_to :company
  attr_accessible :vendor_id
  
  #has_many :vendors, :class_name => "Company", foreign_key: "vendor_id",  dependent: :destroy
  
  def self.get_vendor_list (company_id)
    vendors = Company.joins('inner join company_vendors ON company_vendors.vendor_id = companies.id ').where('company_vendors.company_id' => company_id)
    Rails.logger.debug '=== for company_id='+company_id.to_s+ ', get verdor list size=' + vendors.length.to_s
    return vendors
  end
  
end
