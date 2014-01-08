class RenameSellerIdToVendorIdInOrderPriceHistories < ActiveRecord::Migration
  def up
    rename_column :order_price_histories, :buyer_id, :vendor_id 
  end

  def down
    rename_column :order_price_histories, :vendor_id, :buyer_id
  end
end
