class GoodsExt < ActiveRecord::Base
  belongs_to :goods_prop
  belongs_to :order_goods,  :class_name => "OrderGoods", :foreign_key => "order_goods_id"  # -> { includes :order }, for the effiency of access @goods_ext.order_goods.order
  
  attr_accessible :prop_value, :goods_prop_id, :order_goods_id
  
  
  
  
  def self.addOneExtProp(prop_id, goods_id, val)
    oneExtInfo = GoodsExt.new(goods_prop_id: prop_id, order_goods_id: goods_id, prop_value: val)
    oneExtInfo.save
  end
  
  
end
