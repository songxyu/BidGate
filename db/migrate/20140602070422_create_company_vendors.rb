class CreateCompanyVendors < ActiveRecord::Migration
  def change
    create_table :company_vendors do |t|
      t.references :company
      t.integer :vendor_id

      t.timestamps
    end
    add_index :company_vendors, :company_id
  end
end
