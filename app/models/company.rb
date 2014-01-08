class Company < ActiveRecord::Base
  attr_accessible :register_address, :contact, :contact_tel, :legal_person, :main_biz, 
      :name, :register_capital, :account_num, :license_image
  
  has_many :user, :class_name => "User", dependent: :destroy
end
