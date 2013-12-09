class OrderPriceHistory < ActiveRecord::Base
  belongs_to :order  
  attr_accessible :bid_time, :price, :buyer_id, :order_id
end
