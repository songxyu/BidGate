class RenameSellerIdInOrderPriceHistories < ActiveRecord::Migration
  def up      
    rename_column :order_price_histories, :seller_id, :buyer_id
  end

  def down
    rename_column :order_price_histories, :buyer_id, :seller_id
  end
end
