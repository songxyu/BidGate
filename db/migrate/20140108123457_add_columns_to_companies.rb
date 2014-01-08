class AddColumnsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :license_image, :binary
    add_column :companies, :account_num, :string
  end
end
