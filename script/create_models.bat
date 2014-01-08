REM please put this bat file in folder /script/
cd ..
echo create models...

REM @echo off

call rails generate model Category parent_id:integer  name:string is_parent:boolean  status:integer sort_order:integer

call rails generate model GoodsProp parent_id:integer  name:string status:integer sort_order:integer

call rails generate model GoodsPropValue category:references goods_prop:references  prop_value:string

call rails generate model User nickname:string  company:references user_type:string  status:integer

call rails generate model Order create_time:datetime  price:decimal{8,2} price_type:integer status:integer buyer_id:integer seller_id:integer deal_price:decimal{8,2}  deadline:datetime deal_date:datetime


call rails generate model OrderGoods order:references quantity:integer price:decimal{8,2}  name:string category:string model:string

call rails generate model OrderPriceHistory order:references  bid_time:datetime price:decimal{8,2} seller_id:integer

call rails generate model GoodsExt goods_prop:references prop_value:string order_goods:references

call rails generate model Company name:string contact:string contact_tel:string address:string register_capital:integer main_biz:string  legal_person:string

REM @echo on
echo finished generating models!
pause