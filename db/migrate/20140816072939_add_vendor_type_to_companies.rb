class AddVendorTypeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :vendor_type, :integer
  end
end
