class GoodsProp < ActiveRecord::Base
  attr_accessible :name, :parent_id, :sort_order, :status

  has_many :goods_prop_values, dependent: :destroy
  has_many :goods_exts, dependent: :destroy
  
  # property tree 
  has_many :child_goods_prop, class_name: "GoodsProp", foreign_key: "parent_id" # foreign key must be specified in has_many!
  belongs_to :parent_goods_prop, class_name: "GoodsProp"
end
