REM add more migrations for db schema changes!
REM please put this bat file in folder /script/

cd ..

@echo on

echo add category_id on table orders
call rails generate migration AddCategoryRefToOrders category:references

echo add email, password, signup_time, last_signin_time, last_signin_ip,  on table users
call rails generate migration AddColumnsToUsers email:string  password:string  signup_time:datetime  last_signin_time:datetime  last_signin_ip:string password_digest:string

echo change column seller_id to buyer_id on table order_price_histories
rails generate migration RenameSeller_IdInOrderPriceHistories


echo add image_path  on table categories
call rails generate migration AddImagePathToCategories image_path:string

echo add more columns on table users
call rails generate migration AddMoreColumnsToUsers username:string contact:string contact_cellphone:string contact_tel:string contact_title:integer


echo change column password to password_digest  on table users
call rails generate migration RenamePasswordInUsers

echo remove column user_type on table users
call rails generate migration RemoveUserTypeFromUsers user_type:string 


echo change column seller_id to vendor_id  on table orders
call rails generate migration RenameSellerIdInOrders


echo add more columns on table orders
call rails generate migration AddColumnsToOrders order_num:string location_id:integer payment_method:integer currency:integer vendor_list:string


echo add more columns on table order_goods
call rails generate migration AddColumnsToOrderGoods image:binary memo:string


echo change column seller_id to vendor_id  on table order_price_histories
call rails generate migration RenameSellerIdToVendorIdInOrderPriceHistories


echo change column address to register_address  on table companies
call rails generate migration RenameAddressInCompanies


echo add more columns on table companies
call rails generate migration AddColumnsToCompanies license_image:binary account_num:string

echo add two new tables
call rails generate model Location name:string parent_id:integer  zip_code:integer
call rails generate model FollowRelationship follower_id:integer followed_id:integer


echo add the location column in order table for search
call rails generate migration AddLocationSearchableToOrders location_searchable:string


echo add two new tables
call rails generate model CategoryUnit  category:references  unit_name:string
call rails generate model CategoryPropValueList goods_prop_value:references prop_value:string

echo add memo column on table orders
call rails generate migration AddOrderMemoToOrders order_memo:string

echo  ----- finished changes ----
pause