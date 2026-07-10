-- SALES ANALYTICS
CREATE OR REPLACE VIEW mart.v_sales AS

SELECT

f.sales_key,

d.full_date,
d.year,
d.quarter,
d.month,
d.month_name,

c.customer_id,
c.customer_city,
c.customer_state,

p.product_id,
p.product_category_name_english,

s.seller_id,
s.seller_city,
s.seller_state,

f.order_id,
f.order_item_id,

f.order_status,

f.price,
f.freight_value,
f.total_amount

FROM mart.fact_sales f

JOIN mart.dim_date d
ON f.date_key = d.date_key

JOIN mart.dim_customer c
ON f.customer_key = c.customer_key

JOIN mart.dim_product p
ON f.product_key = p.product_key

JOIN mart.dim_seller s
ON f.seller_key = s.seller_key;

-- PRODUCT PERFORMANCE
CREATE OR REPLACE VIEW mart.v_product_performance AS

SELECT

p.product_category_name_english,

COUNT(*) AS total_items,

SUM(f.price) AS revenue,

SUM(f.freight_value) AS freight,

SUM(f.total_amount) AS total_sales,

AVG(f.price) AS avg_price

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key=p.product_key

GROUP BY
p.product_category_name_english;

-- CUSTOMER ANALYTICS
CREATE OR REPLACE VIEW mart.v_customer_summary AS

SELECT

c.customer_id,

c.customer_city,

c.customer_state,

COUNT(DISTINCT f.order_id) AS orders,

SUM(f.total_amount) AS revenue,

AVG(f.total_amount) AS avg_order_value

FROM mart.fact_sales f

JOIN mart.dim_customer c
ON f.customer_key=c.customer_key

GROUP BY

c.customer_id,
c.customer_city,
c.customer_state;

--SELLER ANALYTICS
CREATE OR REPLACE VIEW mart.v_seller_summary AS

SELECT

s.seller_id,

s.seller_city,

s.seller_state,

COUNT(*) AS items_sold,

SUM(f.total_amount) AS revenue,

AVG(f.total_amount) AS avg_sale

FROM mart.fact_sales f

JOIN mart.dim_seller s
ON f.seller_key=s.seller_key

GROUP BY

s.seller_id,
s.seller_city,
s.seller_state;

--VALIDATION
SELECT COUNT(*) FROM mart.v_sales;

SELECT COUNT(*) FROM mart.v_product_performance;

SELECT COUNT(*) FROM mart.v_customer_summary;

SELECT COUNT(*) FROM mart.v_seller_summary;