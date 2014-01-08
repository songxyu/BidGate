class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_num, :string
    add_column :orders, :location_id, :integer
    add_column :orders, :payment_method, :integer
    add_column :orders, :currency, :integer
    add_column :orders, :vendor_list, :string
  end
end
