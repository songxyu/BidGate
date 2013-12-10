class Company < ActiveRecord::Base
  attr_accessible :address, :contact, :contact_tel, :legal_person, :main_biz, :name, :register_capital
  
  has_one :user, :class_name => "User", dependent: :destroy, inverse_of: :company
end
