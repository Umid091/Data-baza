--1-masala: Product jadvalidan category_id 3 dan katta bo'lgan product_name bo'yicha saralab chiqarilsin.
select product_name  from products
where product_id>3

# ==========================================================================================================

--2-masala: Customer jadvalidan country si brazilya bo'lgan companiya name ning 3 chi harifi kichik n harifi bo'lgan kompaniyalar chiqarilsin
select *from customers
where country in ('Brazil') and company_name like ('n%')
#==================================================================================================================

--3-masala:customer jadvalidan regioni britaniya bo'lgan va kompaniya name ning oxiridan 3 harifi kichik a bo'lgan kompaniyalar chiqarilsin
select company_name  from customers
where  region in ('WA') and company_name like ('%a')

#============================================================================================================================

--4-masala: Product jadvalidagi o'rtacha narxlarni chiqaring
select avg(unit_price) from products

#=====================================================================================================================================

--5-masala: orders jadvalidan 1997 yilining 7 oyining kechikan zakazlar sonini chiqarish
select count(*) as kechikkan_zakazlar_soni
from orders
where extract (YEAR FROM order_date) = 1997 and extract (MONTH FROM order_date) = 7 and shipped_date > required_date;
#===========================================================================================================================================

--6-masala:Product jadvalini 1 category dagi eng qimmat maxsulot ning barcha malumotini chiqarilsin
select * from products
where category_id=1
#=================================================================================================================================================


--============================JADVALNI YARATISH========================
create table categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    picture BYTEA
);


create table suppliers (
    supplier_id SERIAL PRIMARY KEY,
    company_name VARCHAR(40) NOT NULL,
    contact_name VARCHAR(50),
    contact_title VARCHAR(80),
    address VARCHAR(200),
    city VARCHAR(100),
    region VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    phone VARCHAR(50),
    fax VARCHAR(50),
    homepage TEXT
);


create table products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    supplier_id INT,
    category_id INT,
    quantity_per_unit VARCHAR(50),
    unit_price NUMERIC(10,2),
    units_in_stock INT,
    units_on_order INT,
    reorder_level INT,
    discontinued BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
        ON DELETE SET NULL,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE SET NULL
);



create table orders (
    order_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(10),
    employee_id INT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    ship_via INT,
    freight NUMERIC(10,2),
    ship_name VARCHAR(100),
    ship_address VARCHAR(200),
    ship_city VARCHAR(100),
    ship_region VARCHAR(100),
    ship_postal_code VARCHAR(20),
    ship_country VARCHAR(100)
);


create  table order_details (
    order_id INT,
    product_id INT,
    unit_price NUMERIC(10,2) NOT NULL,
    quantity INT NOT NULL,
    discount REAL DEFAULT 0,

    PRIMARY KEY (order_id, product_id),

    CONSTRAINT fk_order_details_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_details_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);
--=============================================================================================






--=======================Jadvalga har birga 5 tadan malumot qo'shish=======================
insert into categories (category_name, description)
values
('ichimliklar', 'sovuq va issiq ichimliklar'),
('shirinliklar', 'shirin mahsulotlar'),
('sut mahsulotlari', 'sut va sutdan tayyorlangan'),
('go‘sht mahsulotlari', 'go‘sht va kolbasa'),
('mevalar', 'faqat mevalar ');


insert into  suppliers (company_name, contact_name, city, country, phone)
values
('good food', 'Ali Valiyev', 'Toshkent', 'Uzbekistan', '+998901111111'),
('besh qazon House', 'Dilshod Karimov', 'Samarqand', 'Uzbekistan', '+998902222222'),
('kamolon', 'Aziza Rustamova', 'Buxoro', 'Uzbekistan', '+998903333333'),
('feed up', 'Jasur Xolmatov', 'Andijon', 'Uzbekistan', '+998904444444'),
('evos', 'Umid jorayev', 'buxoro', 'Uzbekistan', '+998905555555');


insert into products (product_name, supplier_id, category_id,quantity_per_unit, unit_price,units_in_stock, units_on_order,reorder_level, discontinued
)
values
('Coca Cola', 1, 1, '1 litr', 12000, 100, 10, 20,false),
('pitsa', 3, 2, '500 g', 45000, 50, 5, 10, false),
('milk', 2, 3, '1 litr', 9000, 200, 20, 30, false),
('olma', 4, 4, '1 kg', 85000, 40, 5, 10, false),
('banan', 5, 5, '1 kg', 8000, 150, 15, 25, false);


insert into orders (customer_id, employee_id,order_date, required_date, shipped_date,freight, ship_name, ship_city, ship_country
)
values
	('212', 1, '2025-01-01', '2025-01-05', '2025-01-03', 15000, 'Ali Market', 'Toshkent', 'Uzbekistan'),
	('234', 2, '2025-01-02', '2025-01-06', '2025-01-04', 18000, 'Dilshod Shop', 'Samarqand', 'Uzbekistan'),
	('45623', 3, '2025-01-03', '2025-01-07', '2025-01-05', 12000, 'Besh qozon', 'Buxoro', 'Uzbekistan'),
	('2345', 4, '2025-01-04', '2025-01-08', '2025-01-06', 20000, ' Market', 'Andijon', 'Uzbekistan'),
	('0000', 5, '2025-01-05', '2025-01-09', '2025-01-07', 10000, 'feedup', 'Farg‘ona', 'Uzbekistan');

insert into order_details (order_id, product_id, unit_price, quantity, discount)
values
(1, 1, 12000, 5, 0),
(2, 2, 45000, 2, 0.5),
(3, 3, 9000, 10, 0),
(4, 4, 85000, 1, 0),
(5, 5, 8000, 8, 0.00);
--========================================================================================================

--=========================HAR BIR JADVALNI KO'RISH========================================================
select *from categories

select*from suppliers

select*from products

select *from orders

select *from order_details
--=========================================================================================================

--====================JADVAL MALUMOTINI O'CHIRISH==========================================================
delete from categories
where category_id =5


delete from suppliers
where supplier_id=5


delete from products
where product_id=5


delete from orders
where order_id=5


delete from order_details
where order_id=4
--===============================================================================================================



--===================JADVAL MALUMOTINI YANGILASH==================================================================
update categories
set category_name='faqat qosh maxsulotlqi'
where category_id=4


update suppliers
set contact_name='ozodbek farmonov',
	postal_code='123457',
	region='vobkent'
where supplier_id=4

update products
set product_name='qovun',
	unit_price=100.000,
	units_in_stock=20
where product_id=4


update orders
set order_date='2002-01-05',
	ship_name='akobr',
	ship_address='geydar aliyev'
where order_id=4


update order_details
set discount=3,
	unit_price=100
where order_id=3
--===============================================================================================


--====USTUN QO'SHISH=====
alter table suppliers
add column muallif varchar(90);


--====USTUN NOMINI O'ZGARTIRSH==========
alter table  suppliers
RENAME COLUMN muallif TO after;








