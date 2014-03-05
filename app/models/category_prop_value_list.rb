class CategoryPropValueList < ActiveRecord::Base
  belongs_to :goods_prop_value
  attr_accessible :prop_value
end
