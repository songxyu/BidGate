class OrderPriceHistory < ActiveRecord::Base
  belongs_to :order
  belongs_to :vendor, :class_name => "User", :foreign_key => 'vendor_id'  
  
  attr_accessible :bid_time, :price, :vendor_id, :order_id, :bid_memo, :delivery_days, :is_valid
end
