class GoodsExt < ActiveRecord::Base
  belongs_to :goods_prop
  belongs_to :order_goods
  attr_accessible :prop_value
end
