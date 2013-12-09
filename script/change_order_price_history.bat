cd ..

@echo on

echo change column seller_id to buyer_id on table order_price_histories

rails generate migration RenameSeller_IdInOrderPriceHistories

pause