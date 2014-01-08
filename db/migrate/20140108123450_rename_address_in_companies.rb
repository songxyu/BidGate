class RenameAddressInCompanies < ActiveRecord::Migration
  def up
    rename_column :companies, :address, :register_address
  end

  def down
    rename_column :companies, :register_address, :address
  end
end
