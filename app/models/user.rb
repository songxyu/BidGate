class User < ActiveRecord::Base
  belongs_to :company

  has_many :sell_orders, :class_name => "Order", :foreign_key => 'seller_id' #, dependent: :destroy
  has_many :buy_orders, :class_name => "Order", :foreign_key => 'buyer_id' #, dependent: :destroy

  has_many :bid_histories, :class_name => "OrderPriceHistory", :foreign_key => 'buyer_id'

  attr_accessible :nickname, :status, :user_type, :company_id, :email, :password, :signup_time,
              :last_signin_time,  :last_signin_ip, :password_confirmation

  attr_accessor :password, :password_hash, :password_salt
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      self.password = self.password_hash
    end
  end
end
