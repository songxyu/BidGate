class CreateCategoryPropValueLists < ActiveRecord::Migration
  def change
    create_table :category_prop_value_lists do |t|
      t.references :goods_prop_value
      t.string :prop_value

      t.timestamps
    end
    add_index :category_prop_value_lists, :goods_prop_value_id
  end
end
