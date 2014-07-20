class AddColumnsToOrderPriceHistories < ActiveRecord::Migration
  def change
    add_column :order_price_histories, :delivery_days, :integer
    add_column :order_price_histories, :bid_memo, :string
    add_column :order_price_histories, :is_valid, :boolean
  end
end
