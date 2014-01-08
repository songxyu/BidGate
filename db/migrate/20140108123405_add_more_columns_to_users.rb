class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :contact, :string
    add_column :users, :contact_cellphone, :string
    add_column :users, :contact_tel, :string
    add_column :users, :contact_title, :integer
  end
end
