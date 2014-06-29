class OrderGoods < ActiveRecord::Base
  include CategoriesHelper
    
  belongs_to :order
  
  has_many :goods_props 
  has_many :goods_exts, :class_name => "GoodsExt", :foreign_key => "order_goods_id", dependent: :destroy #  through: :goods_props,
  
  attr_accessible :category, :model, :name, :price, :quantity, :order_id, :image, :memo
  
  def order_item_info_str
    order = Order.find(order_id)
    cateUnit = CategoriesHelper.get_category_unit(order.category_id)
    
    # note: when use ? : in string concat, must use ( ? : ) !! 
    retStr = (name ? name : "")  + " " + (model ? model : "") + " " + quantity.to_s +  (cateUnit ? cateUnit.unit_name : " ")
    Rails.logger.debug '=== order_item_info_str: ' + retStr
    return retStr 
  end
end
