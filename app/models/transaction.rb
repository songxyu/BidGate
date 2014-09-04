class Transaction < ActiveRecord::Base
  belongs_to :order
  attr_accessible :buyer_alipay_account, :discount, :gmt_create, :gmt_payment, :gmt_refund, :notify_id, :notify_time, 
            :notify_type, :refund_status, :seller_alipay_account, :total_fee, :trade_no, :trade_status
end
