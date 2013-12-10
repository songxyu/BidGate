# run: rake db:seed

Category.create(name: "钢材", is_parent: true, parent_id: 0, sort_order:1, status: 0)
Category.create(name: "橡胶制品", is_parent: true, parent_id: 0, sort_order: 1, status: 0)
Category.create(name: "木材", is_parent: true, parent_id: 0, sort_order: 1, status: 0)

Category.create(name: "不锈钢", is_parent: false, parent_id: 1, sort_order:2, status: 0)
Category.create(name: "普通钢", is_parent: false, parent_id: 1, sort_order:3, status: 0)
Category.create(name: "高速钢", is_parent: false, parent_id: 1, sort_order:4, status: 0)
Category.create(name: "螺纹钢", is_parent: false, parent_id: 1, sort_order:5, status: 0)
Category.create(name: "硅橡胶", is_parent: false, parent_id: 2, sort_order: 2, status: 0)
Category.create(name: "乙丙胶", is_parent: false, parent_id: 2, sort_order: 3, status: 0)
Category.create(name: "红柳木", is_parent: false, parent_id: 3, sort_order: 2, status: 0)
Category.create(name: "美国红桃木", is_parent: false, parent_id: 4, sort_order: 2, status: 0)


Company.create(name: "无锡博杨制钢有限公司", address: "江苏-无锡", contact:"徐杨", contact_tel: "12345", legal_person:"Mr.Song", main_biz:"诈骗", register_capital: 10000)
Company.create(name: "美国波音公司", address: "美国-西雅图", contact:"Skyler Hampton", contact_tel: "123455", legal_person:"Mr.Song2", main_biz:"诈骗2", register_capital: 20000)
Company.create(name: "南京飞翔科技有限公司", address: "江苏-南京", contact:"孙国庆", contact_tel: "123455", legal_person:"Mr.Song2", main_biz:"诈骗2", register_capital: 20000)
Company.create(name: "杭州四环金属材料有限公司", address: "浙江-杭州", contact:"王日云", contact_tel: "0571-88942193", legal_person:"王日云", main_biz:"批发、零售：金属材料、冶金原料", register_capital: 500000)
Company.create(name: "杭州拱墅区普庆不锈钢商行", address: "浙江-杭州", contact:"周樟妹", contact_tel: "0571-56793305", legal_person:"李坤富", main_biz:"不锈钢的批发与零售", register_capital: 1000000)
Company.create(name: "海宁市凯丽橡胶厂", address: "浙江-海宁", contact:"黄志华", contact_tel: "0573-87887226", legal_person:"黄志华", main_biz:"橡胶制品、硅胶制品", register_capital: 500000)
Company.create(name: "深圳市金龙威实业有限公司", address: "深圳", contact:"梁益云", contact_tel: "0755-27348292", legal_person:"梁章明", main_biz:"硅胶按键、斑马纸", register_capital: 1000000)
Company.create(name: "上海宝赛木业有限公司", address: "上海", contact:"", contact_tel: "021-57392286", legal_person:"卢武军", main_biz:"木材、胶合板", register_capital: 1000000)

User.create(nickname: "波音销售-Matt Peterson", status: 0, user_type: "B", company_id: 2)
User.create(nickname: "王凡", status: 0, user_type: "B", company_id: 1)
User.create(nickname: "刘金添", status: 0, user_type: "S", company_id: 3)
User.create(nickname: "赵方", status: 0, user_type: "S", company_id: 4)
User.create(nickname: "陈伟", status: 0, user_type: "B", company_id: 5)
User.create(nickname: "陈倩", status: 0, user_type: "S", company_id: 6)
User.create(nickname: "廖光文", status: 0, user_type: "B", company_id: 7)

GoodsProp.create(name:"形状", parent_id: 0, sort_order:1, status: 0)
GoodsProp.create(name:"材质", parent_id: 0, sort_order:2, status: 0)
GoodsProp.create(name:"产地", parent_id: 0, sort_order:3, status: 0)
GoodsProp.create(name:"规格", parent_id: 0, sort_order:4, status: 0)


GoodsPropValue.create(prop_value:"钢丝", category_id: 3, goods_prop_id:1)
GoodsPropValue.create(prop_value:"200系列", category_id: 3, goods_prop_id:2)
GoodsPropValue.create(prop_value:"宝钢", category_id: 3, goods_prop_id:3)
GoodsPropValue.create(prop_value:"长度:1~60mm", category_id: 3, goods_prop_id:4)
GoodsPropValue.create(prop_value:"丁苯橡胶", category_id: 5, goods_prop_id:1)
GoodsPropValue.create(prop_value:"SBS", category_id: 5, goods_prop_id:2)
GoodsPropValue.create(prop_value:"齐鲁石化", category_id: 5, goods_prop_id:3)
GoodsPropValue.create(prop_value:"分子式:C12H14", category_id: 5, goods_prop_id:4)
GoodsPropValue.create(prop_value:"木板", category_id: 7, goods_prop_id:1)
GoodsPropValue.create(prop_value:"铁梨木", category_id: 7, goods_prop_id:2)
GoodsPropValue.create(prop_value:"上海", category_id: 7, goods_prop_id:3)
GoodsPropValue.create(prop_value:"缅甸菠萝格", category_id: 7, goods_prop_id:4)

## price_type:
#	1: Bid
#   2: BuyItNow
## status:
#   1: Selled
#   2: OnBiding
Order.create(category_id:2, seller_id:1, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 20000, price: 20000, price_type: '2', buyer_id: 2, status: 1)
Order.create(category_id:2, seller_id:2, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 35000, price: 22000, price_type: '1', buyer_id: 3, status: 2)
Order.create(category_id:3, seller_id:3, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 100000, price: 95000, price_type: '1', buyer_id: 5, status: 1)
Order.create(category_id:5, seller_id:4, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 47000, price: 46000, price_type: '1', buyer_id: 1, status: 1)
Order.create(category_id:7, seller_id:5, create_time: DateTime.new(2013,11,20), deadline: DateTime.new(2013,11,20), deal_date: 0, deal_price: 88000, price: 70000, price_type: '2', buyer_id: 6, status: 2)

# OrderGoods
OrderGoods.create(order_id: 1, quantity: 50, price: 400, name: "不锈钢", category: '钢材', model: '301')
OrderGoods.create(order_id: 2, quantity: 100, price: 350, name: "普通钢", category: '钢材', model: 'Q235')
OrderGoods.create(order_id: 3, quantity: 100, price: 4000, name: "不锈钢", category: '钢材', model: '402')
OrderGoods.create(order_id: 4, quantity: 470, price: 100, name: "模具钢", category: '钢材', model: 'HPB223')
OrderGoods.create(order_id: 5, quantity: 8800, price: 10, name: "红木", category: '木材', model: 'MZ55')
#OrderPriceHistory

#OrderPriceHistory
OrderPriceHistory.create(order_id: 1, price: 20000, buyer_id: 2, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 2, price: 25000, buyer_id: 3, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 2, price: 35000, buyer_id: 4, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 3, price: 96000, buyer_id: 6, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 3, price: 98000, buyer_id: 7, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 3, price: 100000, buyer_id: 5, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 4, price: 47000, buyer_id: 1, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 5, price: 79000, buyer_id: 3, bid_time: DateTime.new(2013,11,20))
OrderPriceHistory.create(order_id: 5, price: 87000, buyer_id: 7, bid_time: DateTime.new(2013,11,20))

# GoodsExt
GoodsExt.create(goods_prop_id: 3, prop_value: "宝钢", order_goods_id: 1)
GoodsExt.create(goods_prop_id: 4, prop_value: "直径100mm", order_goods_id: 1)


GoodsExt.create(goods_prop_id: 1, prop_value: "长方体截面", order_goods_id: 2)
GoodsExt.create(goods_prop_id: 4, prop_value: "长100mm宽55mm", order_goods_id: 2)
# 3.times do |i|
  # Category.create(name: "Product ##{i}", description: "A product.")
# end