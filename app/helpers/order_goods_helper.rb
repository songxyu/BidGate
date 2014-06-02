module OrderGoodsHelper
  
  # common properties for all categories' goods
  def get_common_properties
    return [  # not work yet
      {id: "name", name: "货物"}, {id: "model", name: "型号"}, {id: "location", name: "产地"},
      {id: "quantity", name: "数量"}, {id: "operation", name: "删除"} 
    ]
  end
  
end
