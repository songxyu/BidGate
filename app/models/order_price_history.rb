class OrderPriceHistory < ActiveRecord::Base
  belongs_to :order
  belongs_to :buyer, :class_name => "User", :foreign_key => 'buyer_id'  
  
  attr_accessible :bid_time, :price, :buyer_id, :order_id
end
