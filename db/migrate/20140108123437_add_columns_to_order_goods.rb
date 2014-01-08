class AddColumnsToOrderGoods < ActiveRecord::Migration
  def change
    add_column :order_goods, :image, :binary
    add_column :order_goods, :memo, :string
  end
end
