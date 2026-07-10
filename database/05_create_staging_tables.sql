-- =====================================================
-- Project : Product & Revenue Intelligence Platform
-- File    : 05_create_staging_tables.sql
-- Layer   : STAGING
-- =====================================================

SET search_path TO staging;

-- =====================================================
-- CUSTOMERS
-- =====================================================

CREATE TABLE IF NOT EXISTS customers (

    customer_id VARCHAR(32) PRIMARY KEY,

    customer_unique_id VARCHAR(32) NOT NULL,

    customer_zip_code_prefix INTEGER,

    customer_city VARCHAR(100),

    customer_state CHAR(2)

);

-- =====================================================
-- PRODUCTS
-- =====================================================

CREATE TABLE IF NOT EXISTS products (

    product_id VARCHAR(32) PRIMARY KEY,

    product_category_name VARCHAR(100),

    product_category_name_english VARCHAR(100),

    product_name_lenght INTEGER,

    product_description_lenght INTEGER,

    product_photos_qty INTEGER,

    product_weight_g INTEGER,

    product_length_cm INTEGER,

    product_height_cm INTEGER,

    product_width_cm INTEGER

);

-- =====================================================
-- ORDERS
-- =====================================================

CREATE TABLE IF NOT EXISTS orders (

    order_id VARCHAR(32) PRIMARY KEY,

    customer_id VARCHAR(32),

    order_status VARCHAR(20),

    order_purchase_timestamp TIMESTAMP,

    order_approved_at TIMESTAMP,

    order_delivered_carrier_date TIMESTAMP,

    order_delivered_customer_date TIMESTAMP,

    order_estimated_delivery_date TIMESTAMP

);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

CREATE TABLE IF NOT EXISTS order_items (

    order_id VARCHAR(32),

    order_item_id INTEGER,

    product_id VARCHAR(32),

    seller_id VARCHAR(32),

    shipping_limit_date TIMESTAMP,

    price NUMERIC(10,2),

    freight_value NUMERIC(10,2),

    PRIMARY KEY(order_id, order_item_id)

);

-- =====================================================
-- PAYMENTS
-- =====================================================

CREATE TABLE IF NOT EXISTS payments (

    order_id VARCHAR(32),

    payment_sequential INTEGER,

    payment_type VARCHAR(30),

    payment_installments INTEGER,

    payment_value NUMERIC(10,2),

    PRIMARY KEY(order_id, payment_sequential)

);

-- =====================================================
-- REVIEWS
-- =====================================================

CREATE TABLE IF NOT EXISTS reviews (

    review_id VARCHAR(32),

    order_id VARCHAR(32),

    review_score INTEGER,

    review_comment_title VARCHAR(100),

    review_comment_message TEXT,

    review_creation_date TIMESTAMP,

    review_answer_timestamp TIMESTAMP,

    PRIMARY KEY(review_id, order_id)

);

-- =====================================================
-- SELLERS
-- =====================================================

CREATE TABLE IF NOT EXISTS sellers (

    seller_id VARCHAR(32) PRIMARY KEY,

    seller_zip_code_prefix INTEGER,

    seller_city VARCHAR(100),

    seller_state CHAR(2)

);