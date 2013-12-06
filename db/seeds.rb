# run: rake db:seed

Category.create(name: "钢材", is_parent: true, parent_id: 0, sort_order:1, status: 0)

Category.create(name: "不锈钢", is_parent: false, parent_id: 1, sort_order:2, status: 0)
Category.create(name: "普通钢", is_parent: false, parent_id: 1, sort_order:3, status: 0)
Category.create(name: "高速钢", is_parent: false, parent_id: 1, sort_order:4, status: 0)


Company.create(name: "一百万", address: "南京", contact:"Mike", contact_tel: "12345", legal_person:"Mr.Song", main_biz:"诈骗", register_capital: 10000)
Company.create(name: "飞翔科技", address: "南京", contact:"Tom", contact_tel: "123455", legal_person:"Mr.Song2", main_biz:"诈骗2", register_capital: 20000)

User.create(nickname: "Mike", status: 0, user_type: "B", company_id: 1)
User.create(nickname: "Tom", status: 0, user_type: "B", company_id: 2)
User.create(nickname: "Jacky", status: 0, user_type: "S", company_id: 1)
User.create(nickname: "Matt", status: 0, user_type: "B", company_id: 2)

GoodsProp.create(name:"形状", parent_id: 0, sort_order:1, status: 0)
GoodsProp.create(name:"材质", parent_id: 0, sort_order:2, status: 0)
GoodsProp.create(name:"产地", parent_id: 0, sort_order:3, status: 0)
GoodsProp.create(name:"规格", parent_id: 0, sort_order:4, status: 0)


GoodsPropValue.create(prop_value:"钢丝", category_id: 1, goods_prop_id:1)
GoodsPropValue.create(prop_value:"200系列", category_id: 1, goods_prop_id:2)
GoodsPropValue.create(prop_value:"宝钢", category_id: 1, goods_prop_id:3)
GoodsPropValue.create(prop_value:"长度:1~60mm", category_id: 1, goods_prop_id:4)

## price_type:
#	1: Bid
#   2: BuyItNow
## status:
#   1: Selled
#   2: OnBiding
Order.create(buyer_id:1, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 20000, price: 20000, price_type: '2', seller_id: 2, status: 1)
Order.create(buyer_id:2, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 35000, price: 22000, price_type: '1', seller_id: 3, status: 2)
Order.create(buyer_id:3, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 100000, price: 95000, price_type: '1', seller_id: 4, status: 1)
Order.create(buyer_id:4, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 47000, price: 46000, price_type: '1', seller_id: 1, status: 1)
Order.create(buyer_id:2, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 88000, price: 70000, price_type: '2', seller_id: 3, status: 2)

# OrderGoods
OrderGoods.create(order_id: 1, quantity: 50, price: 400, name: "不锈钢", category: '钢材', model: '301')
OrderGoods.create(order_id: 2, quantity: 100, price: 350, name: "普通钢", category: '钢材', model: 'Q235')
OrderGoods.create(order_id: 3, quantity: 100, price: 4000, name: "不锈钢", category: '钢材', model: '402')
OrderGoods.create(order_id: 4, quantity: 470, price: 100, name: "模具钢", category: '钢材', model: 'HPB223')
OrderGoods.create(order_id: 5, quantity: 8800, price: 10, name: "红木", category: '木材', model: 'MZ55')
#OrderPriceHistory



# 3.times do |i|
  # Category.create(name: "Product ##{i}", description: "A product.")
# end