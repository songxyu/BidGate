class User < ActiveRecord::Base
  belongs_to :company

  has_many :sell_orders, :class_name => "Order", :foreign_key => 'seller_id' #, dependent: :destroy
  has_many :buy_orders, :class_name => "Order", :foreign_key => 'buyer_id' #, dependent: :destroy

  has_many :bid_histories, :class_name => "OrderPriceHistory", :foreign_key => 'buyer_id'

  attr_accessible :nickname, :status, :company_id, :email, :password, :signup_time,
              :last_signin_time,  :last_signin_ip, :password_confirmation, :username,
              :contact, :contact_cellphone, :contact_tel, :contact_title

  #attr_accessor :password # do not set this accessor!
  before_save { self.email = email.downcase } #:encrypt_password

  # use has_secure_password instead, no need for this
  #validates_confirmation_of :password
  #validates_presence_of :password, :on => :create
  
  validates :password, length: { minimum: 1 }
  validates_presence_of :email
  validates_uniqueness_of :email
  
  has_secure_password
  
  def self.authenticate(email, password)
    user = find_by_email(email.downcase)
    #if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  # def encrypt_password
#      
    # if password.present?
      # self.password_salt = BCrypt::Engine.generate_salt
      # self.password = BCrypt::Engine.hash_secret(password, password_salt)
#             
      # logger.debug "User: password_salt="+ self.password_salt + ',  encrypted_password='+self.password
      # #p( self )      
    # end
  # end
end
