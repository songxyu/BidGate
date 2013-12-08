class OrderGoods < ActiveRecord::Base
  belongs_to :order
  
  has_many :goods_props 
  has_many :goods_exts, through: :goods_props, dependent: :destroy
  
  attr_accessible :category, :model, :name, :price, :quantity, :order_id
end
