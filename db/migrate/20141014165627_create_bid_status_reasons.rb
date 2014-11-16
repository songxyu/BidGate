class CreateBidStatusReasons < ActiveRecord::Migration
  def change
    create_table :bid_status_reasons do |t|
      t.references :order
      t.references :user
      t.integer :status
      t.integer :reason

      t.timestamps
    end
    add_index :bid_status_reasons, :order_id
    add_index :bid_status_reasons, :user_id
  end
end
