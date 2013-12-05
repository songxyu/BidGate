class CreateGoodsExts < ActiveRecord::Migration
  def change
    create_table :goods_exts do |t|
      t.references :goods_prop
      t.string :prop_value
      t.references :order_goods

      t.timestamps
    end
    add_index :goods_exts, :goods_prop_id
    add_index :goods_exts, :order_goods_id
  end
end
