class RenameSellerIdInOrders < ActiveRecord::Migration
  def up
    rename_column :orders, :seller_id, :vendor_id
  end

  def down
    rename_column :orders, :vendor_id, :seller_id
  end
end
