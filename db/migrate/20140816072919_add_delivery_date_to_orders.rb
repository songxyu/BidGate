class AddDeliveryDateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_date, :datetime
  end
end
