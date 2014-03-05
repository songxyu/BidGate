class AddOrderMemoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_memo, :string
  end
end
