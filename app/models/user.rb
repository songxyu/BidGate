class User < ActiveRecord::Base
  belongs_to :company, inverse_of: user
  has_many :orders #, dependent: :destroy
  
  attr_accessible :nickname, :status, :user_type, :company_id
end
