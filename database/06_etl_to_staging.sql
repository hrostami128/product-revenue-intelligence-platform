-- =====================================================
-- Project : Product & Revenue Intelligence Platform
-- File    : 06_etl_to_staging.sql
-- Layer   : STAGING
--
-- Description:
-- Clean, standardize and transform raw data
-- before loading into staging.
-- =====================================================
STEP 1
TRUNCATE TABLE staging.order_items CASCADE;
TRUNCATE TABLE staging.orders CASCADE;
TRUNCATE TABLE staging.customers CASCADE;
TRUNCATE TABLE staging.products CASCADE;
TRUNCATE TABLE staging.sellers CASCADE;
TRUNCATE TABLE staging.payments CASCADE;
TRUNCATE TABLE staging.reviews CASCADE;

STEP 2 : CUSTOMERS
INSERT INTO staging.customers

SELECT

customer_id,

customer_unique_id,

customer_zip_code_prefix,

TRIM(customer_city),

UPPER(customer_state)

FROM raw.customers;

step 3 : products
INSERT INTO staging.products

SELECT

p.product_id,

p.product_category_name,

t.product_category_name_english,

p.product_name_lenght,

p.product_description_lenght,

p.product_photos_qty,

p.product_weight_g,

p.product_length_cm,

p.product_height_cm,

p.product_width_cm

FROM raw.products p

LEFT JOIN raw.category_translation t

ON p.product_category_name=t.product_category_name;

STEP 4 : SELLERS
INSERT INTO staging.sellers

SELECT

seller_id,

seller_zip_code_prefix,

TRIM(seller_city),

UPPER(seller_state)

FROM raw.sellers;

STEP 5 : ORDERS
INSERT INTO staging.orders

SELECT

order_id,

customer_id,

LOWER(order_status),

order_purchase_timestamp,

order_approved_at,

order_delivered_carrier_date,

order_delivered_customer_date,

order_estimated_delivery_date

FROM raw.orders;

STEP 6 : ORDERS ITEMS
INSERT INTO staging.order_items

SELECT

order_id,

order_item_id,

product_id,

seller_id,

shipping_limit_date,

price,

freight_value

FROM raw.order_items;

STEP 7: PAYMENTS
INSERT INTO staging.payments

SELECT

order_id,

payment_sequential,

LOWER(payment_type),

payment_installments,

payment_value

FROM raw.payments;

STEP 8 : REVIEWS
INSERT INTO staging.reviews

SELECT

review_id,

order_id,

review_score,

TRIM(review_comment_title),

TRIM(review_comment_message),

review_creation_date,

review_answer_timestamp

FROM raw.reviews;

STEP 9 : VALIDATION
SELECT 'customers',COUNT(*) FROM staging.customers
UNION ALL
SELECT 'products',COUNT(*) FROM staging.products
UNION ALL
SELECT 'orders',COUNT(*) FROM staging.orders
UNION ALL
SELECT 'order_items',COUNT(*) FROM staging.order_items
UNION ALL
SELECT 'payments',COUNT(*) FROM staging.payments
UNION ALL
SELECT 'reviews',COUNT(*) FROM staging.reviews
UNION ALL
SELECT 'sellers',COUNT(*) FROM staging.sellers;