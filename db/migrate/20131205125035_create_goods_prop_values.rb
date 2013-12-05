class CreateGoodsPropValues < ActiveRecord::Migration
  def change
    create_table :goods_prop_values do |t|
      t.references :category
      t.references :goods_prop
      t.string :prop_value

      t.timestamps
    end
    add_index :goods_prop_values, :category_id
    add_index :goods_prop_values, :goods_prop_id
  end
end
