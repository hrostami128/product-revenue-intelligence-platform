-- =====================================================
-- Project : Product & Revenue Intelligence Platform
-- File    : 07_create_mart_tables.sql
-- Layer   : MART
-- =====================================================

SET search_path TO mart;

-- =====================================================
-- DIM DATE
-- =====================================================

CREATE TABLE IF NOT EXISTS dim_date (

    date_key INTEGER PRIMARY KEY,

    full_date DATE NOT NULL UNIQUE,

    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    week INTEGER,
    day INTEGER,
    weekday_name VARCHAR(20),
    is_weekend BOOLEAN

);

-- =====================================================
-- DIM CUSTOMER
-- =====================================================

CREATE TABLE IF NOT EXISTS dim_customer (

    customer_key INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    customer_id VARCHAR(32) UNIQUE,

    customer_unique_id VARCHAR(32),

    customer_zip_code_prefix INTEGER,

    customer_city VARCHAR(100),

    customer_state CHAR(2)

);

-- =====================================================
-- DIM PRODUCT
-- =====================================================

CREATE TABLE IF NOT EXISTS dim_product (

    product_key INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    product_id VARCHAR(32) UNIQUE,

    product_category_name VARCHAR(100),

    product_category_name_english VARCHAR(100),

    product_name_length INTEGER,

    product_description_length INTEGER,

    product_photos_qty INTEGER,

    product_weight_g INTEGER,

    product_length_cm INTEGER,

    product_height_cm INTEGER,

    product_width_cm INTEGER

);

-- =====================================================
-- DIM SELLER
-- =====================================================

CREATE TABLE IF NOT EXISTS dim_seller (

    seller_key INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    seller_id VARCHAR(32) UNIQUE,

    seller_zip_code_prefix INTEGER,

    seller_city VARCHAR(100),

    seller_state CHAR(2)

);

-- =====================================================
-- FACT SALES
-- =====================================================

CREATE TABLE IF NOT EXISTS fact_sales (

    sales_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    date_key INTEGER NOT NULL,

    customer_key INTEGER NOT NULL,

    product_key INTEGER NOT NULL,

    seller_key INTEGER NOT NULL,

    order_id VARCHAR(32) NOT NULL,

    order_item_id INTEGER NOT NULL,

    payment_type VARCHAR(30),

    payment_installments INTEGER,

    order_status VARCHAR(20),

    review_score INTEGER,

    price NUMERIC(10,2),

    freight_value NUMERIC(10,2),

    total_amount NUMERIC(10,2),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    FOREIGN KEY (seller_key)
        REFERENCES dim_seller(seller_key)

);
-- ==========================================
-- UNIQUE CONSTRAINT
-- ==========================================

ALTER TABLE mart.fact_sales
ADD CONSTRAINT uq_fact_sales_order_item
UNIQUE (order_id, order_item_id);

-- ==========================================
-- INDEXES
-- ==========================================

CREATE INDEX IF NOT EXISTS idx_dim_customer_customer_id
ON mart.dim_customer(customer_id);

CREATE INDEX IF NOT EXISTS idx_dim_product_product_id
ON mart.dim_product(product_id);

CREATE INDEX IF NOT EXISTS idx_dim_seller_seller_id
ON mart.dim_seller(seller_id);

CREATE INDEX IF NOT EXISTS idx_dim_date_full_date
ON mart.dim_date(full_date);

CREATE INDEX IF NOT EXISTS idx_fact_sales_date_key
ON mart.fact_sales(date_key);

CREATE INDEX IF NOT EXISTS idx_fact_sales_customer_key
ON mart.fact_sales(customer_key);

CREATE INDEX IF NOT EXISTS idx_fact_sales_product_key
ON mart.fact_sales(product_key);

CREATE INDEX IF NOT EXISTS idx_fact_sales_seller_key
ON mart.fact_sales(seller_key);