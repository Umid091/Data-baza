# 1-masala: Product jadvalidan category_id 3 dan katta bo'lgan product_name bo'yicha saralab chiqarilsin.
# select product_name  from products
# where product_id>3
#
## ==========================================================================================================

# 2-masala: Customer jadvalidan country si brazilya bo'lgan companiya name ning 3 chi harifi kichik n harifi bo'lgan kompaniyalar chiqarilsin
# select *from customers
# where country in ('Brazil') and company_name like ('n%')
# #==================================================================================================================
#
# 3-masala:customer jadvalidan regioni britaniya bo'lgan va kompaniya name ning oxiridan 3 harifi kichik a bo'lgan kompaniyalar chiqarilsin
# select company_name  from customers
# where  region in ('WA') and company_name like ('%a')
#
# #============================================================================================================================
#
# 4-masala: Product jadvalidagi o'rtacha narxlarni chiqaring
# select avg(unit_price) from products
#
##=====================================================================================================================================

# 5-masala: orders jadvalidan 1997 yilining 7 oyining kechikan zakazlar sonini chiqarish
# select count(*) as kechikkan_zakazlar_soni
# from orders
# where extract (YEAR FROM order_date) = 1997 and extract (MONTH FROM order_date) = 7 and shipped_date > required_date;
##===========================================================================================================================================
#
# 6-masala:Product jadvalini 1 category dagi eng qimmat maxsulot ning barcha malumotini chiqarilsin
# select * from products
# where category_id=1
##=================================================================================================================================================
