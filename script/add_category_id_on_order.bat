cd ..

@echo on

echo add category_id on table orders

rails generate migration AddCategoryRefToOrders category:references

pause