class AddDeliveryAddrToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_addr, :string
  end
end
