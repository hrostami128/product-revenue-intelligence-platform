-- =====================================================
-- Project : Product & Revenue Intelligence Platform
-- File    : 08_etl_to_mart.sql
-- Layer   : MART
-- =====================================================

BEGIN;

-- ==========================================
-- CLEAN MART
-- ==========================================

TRUNCATE TABLE
    mart.fact_sales,
    mart.dim_customer,
    mart.dim_product,
    mart.dim_seller,
    mart.dim_date
RESTART IDENTITY CASCADE;
-- LOAD CUSTOMER
INSERT INTO mart.dim_customer
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM staging.customers;

-- LOAD PRODUCT
INSERT INTO mart.dim_product
(
    product_id,
    product_category_name,
    product_category_name_english,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT DISTINCT
    product_id,
    product_category_name,
    product_category_name_english,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM staging.products;

-- LOAD SELLER
INSERT INTO mart.dim_seller
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT DISTINCT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM staging.sellers;

-- CREATE DIM DATE 
INSERT INTO mart.dim_date
(
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    week,
    day,
    weekday_name,
    is_weekend
)

SELECT

TO_CHAR(d::date,'YYYYMMDD')::INTEGER,

d::date,

EXTRACT(YEAR FROM d),

EXTRACT(QUARTER FROM d),

EXTRACT(MONTH FROM d),

TO_CHAR(d,'Month'),

EXTRACT(WEEK FROM d),

EXTRACT(DAY FROM d),

TO_CHAR(d,'Day'),

CASE
    WHEN EXTRACT(ISODOW FROM d) IN (6,7)
    THEN TRUE
    ELSE FALSE
END

FROM generate_series(

(
SELECT MIN(order_purchase_timestamp)::date
FROM staging.orders
),

(
SELECT MAX(order_purchase_timestamp)::date
FROM staging.orders
),

INTERVAL '1 day'

) AS d;

--CREATE FACT **
INSERT INTO mart.fact_sales
(
    date_key,
    customer_key,
    product_key,
    seller_key,
    order_id,
    order_item_id,
    order_status,
    price,
    freight_value,
    total_amount
)

SELECT

TO_CHAR(o.order_purchase_timestamp::date,'YYYYMMDD')::INTEGER,

dc.customer_key,

dp.product_key,

ds.seller_key,

oi.order_id,

oi.order_item_id,

o.order_status,

oi.price,

oi.freight_value,

oi.price + oi.freight_value

FROM staging.order_items oi

INNER JOIN staging.orders o
ON oi.order_id = o.order_id

INNER JOIN mart.dim_customer dc
ON o.customer_id = dc.customer_id

INNER JOIN mart.dim_product dp
ON oi.product_id = dp.product_id

INNER JOIN mart.dim_seller ds
ON oi.seller_id = ds.seller_id;

--VALIDATION
SELECT COUNT(*) FROM mart.dim_customer;

SELECT COUNT(*) FROM mart.dim_product;

SELECT COUNT(*) FROM mart.dim_seller;

SELECT COUNT(*) FROM mart.dim_date;

SELECT COUNT(*) FROM mart.fact_sales;

COMMIT;