class BidStatusReason < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  attr_accessible :reason, :status
end
