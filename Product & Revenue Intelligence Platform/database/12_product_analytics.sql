/*==============================================================
12_product_analytics.sql

Project:
Product & Revenue Intelligence Platform

Purpose:
Product Analytics

Layer:
Mart
==============================================================*/
-- Top Product Categories by Revenue

SELECT

    p.product_category_name_english,

    ROUND(SUM(f.total_amount),2) AS revenue,

    COUNT(DISTINCT f.order_id) AS total_orders

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY p.product_category_name_english

ORDER BY revenue DESC;

-- Top Products

SELECT

    p.product_id,

    p.product_category_name_english,

    ROUND(SUM(f.total_amount),2) AS revenue,

    COUNT(*) AS order_items

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY
    p.product_id,
    p.product_category_name_english

ORDER BY revenue DESC

LIMIT 20;

-- Average Price by Category

SELECT

    p.product_category_name_english,

    ROUND(AVG(f.price),2) AS average_price

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY p.product_category_name_english

ORDER BY average_price DESC;

-- Freight Cost by Category

SELECT

    p.product_category_name_english,

    ROUND(AVG(f.freight_value),2) AS average_freight,

    ROUND(SUM(f.freight_value),2) AS total_freight

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY p.product_category_name_english

ORDER BY total_freight DESC;

-- Seller Performance

SELECT

    s.seller_state,

    COUNT(DISTINCT s.seller_id) AS total_sellers,

    ROUND(SUM(f.total_amount),2) AS revenue

FROM mart.fact_sales f

JOIN mart.dim_seller s
ON f.seller_key = s.seller_key

GROUP BY s.seller_state

ORDER BY revenue DESC;

-- Product Category Performance

SELECT

    p.product_category_name_english,

    COUNT(*) AS order_items,

    ROUND(SUM(f.total_amount),2) AS revenue,

    ROUND(AVG(f.price),2) AS average_price

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY p.product_category_name_english

ORDER BY revenue DESC;



