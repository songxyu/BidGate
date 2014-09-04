class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :notify_id
      t.string :notify_type
      t.datetime :notify_time
      t.string :trade_no
      t.integer :trade_status
      t.string :buyer_alipay_account
      t.string :seller_alipay_account
      t.decimal :total_fee, :precision => 8, :scale => 2
      t.decimal :discount, :precision => 8, :scale => 2
      t.references :order
      t.datetime :gmt_create
      t.datetime :gmt_payment
      t.integer :refund_status
      t.datetime :gmt_refund

      t.timestamps
    end
    add_index :transactions, :order_id
  end
end
