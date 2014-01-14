class AddLocationSearchableToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :location_searchable, :string
  end
end
