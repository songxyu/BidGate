class GoodsPropValue < ActiveRecord::Base
  belongs_to :category
  belongs_to :goods_prop
  attr_accessible :prop_value, :category_id, :goods_prop_id
end
