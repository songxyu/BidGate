class OrderGoods < ActiveRecord::Base
  belongs_to :order
  
  has_many :goods_props 
  has_many :goods_exts, :class_name => "GoodsExt", :foreign_key => "order_goods_id", dependent: :destroy #  through: :goods_props,
  
  attr_accessible :category, :model, :name, :price, :quantity, :order_id, :image, :memo
  
  def order_item_info_str
    return name + model + " " + quantity.to_s + " 千克" # TODO: unit
  end
end
