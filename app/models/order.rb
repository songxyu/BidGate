class Order < ActiveRecord::Base
  attr_accessible :buyer_id, :create_time, :deadline, :deal_date, :deal_price, :price, :price_type, :seller_id, :status, :category_id

  belongs_to :category  
  has_many :order_goods, :class_name => "OrderGoods", dependent: :destroy # here must specify the class_name as rails will resolve as order_good!
  has_many :order_price_histories, dependent: :destroy
  
  belongs_to :buyer, :class_name => "User", :foreign_key => 'buyer_id'
  belongs_to :seller, :class_name => "User", :foreign_key => 'seller_id'
end
