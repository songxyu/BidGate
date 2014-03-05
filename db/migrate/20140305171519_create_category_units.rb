class CreateCategoryUnits < ActiveRecord::Migration
  def change
    create_table :category_units do |t|
      t.references :category
      t.string :unit_name

      t.timestamps
    end
    add_index :category_units, :category_id
  end
end
