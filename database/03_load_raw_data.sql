-- =====================================================
-- Project : Product & Revenue Intelligence Platform
-- File    : 03_load_raw_data.sql
-- Layer   : RAW
--
-- Description:
-- Load source CSV files into raw schema tables.
-- =====================================================

SET search_path TO raw;

-- =====================================================
-- CUSTOMERS
-- =====================================================

COPY raw.customers
FROM 'YOUR_PATH\data\raw\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- GEOLOCATION
-- =====================================================

COPY raw.geolocation
FROM 'YOUR_PATH\data\raw\olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- ORDERS
-- =====================================================

COPY raw.orders
FROM 'YOUR_PATH\data\raw\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- ORDER ITEMS
-- =====================================================

COPY raw.order_items
FROM 'YOUR_PATH\data\raw\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- PAYMENTS
-- =====================================================

COPY raw.payments
FROM 'YOUR_PATH\data\raw\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- REVIEWS
-- =====================================================

COPY raw.reviews
FROM 'YOUR_PATH\data\raw\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- PRODUCTS
-- =====================================================

COPY raw.products
FROM 'YOUR_PATH\data\raw\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- SELLERS
-- =====================================================

COPY raw.sellers
FROM 'YOUR_PATH\data\raw\olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- =====================================================
-- CATEGORY TRANSLATION
-- =====================================================

COPY raw.category_translation
FROM 'YOUR_PATH\data\raw\product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;