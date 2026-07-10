/*==============================================================
13_pricing_analytics.sql

Project:
Product & Revenue Intelligence Platform

Purpose:
Pricing Analytics

Layer:
Mart
==============================================================*/
-- Price Distribution

SELECT

    CASE

        WHEN price < 50 THEN 'Under $50'

        WHEN price BETWEEN 50 AND 100 THEN '$50 - $100'

        WHEN price BETWEEN 100 AND 250 THEN '$100 - $250'

        WHEN price BETWEEN 250 AND 500 THEN '$250 - $500'

        ELSE 'Above $500'

    END AS price_range,

    COUNT(*) AS total_items,

    ROUND(SUM(total_amount),2) AS revenue

FROM mart.fact_sales

GROUP BY price_range

ORDER BY MIN(price);

-- Average Price by Category

SELECT

    p.product_category_name_english,

    ROUND(AVG(f.price),2) AS average_price,

    ROUND(SUM(f.total_amount),2) AS revenue

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY p.product_category_name_english

ORDER BY average_price DESC;

-- Freight Analysis

SELECT

    ROUND(AVG(price),2) AS average_price,

    ROUND(AVG(freight_value),2) AS average_freight,

    ROUND(
        AVG(freight_value) / NULLIF(AVG(price),0) * 100,
        2
    ) AS freight_percent

FROM mart.fact_sales;

-- Revenue by Price Range

SELECT

    CASE

        WHEN price < 50 THEN 'Under $50'

        WHEN price BETWEEN 50 AND 100 THEN '$50 - $100'

        WHEN price BETWEEN 100 AND 250 THEN '$100 - $250'

        WHEN price BETWEEN 250 AND 500 THEN '$250 - $500'

        ELSE 'Above $500'

    END AS price_range,

    ROUND(SUM(total_amount),2) AS revenue,

    COUNT(*) AS order_items

FROM mart.fact_sales

GROUP BY price_range

ORDER BY revenue DESC;

-- Highest Priced Products

SELECT

    p.product_id,

    p.product_category_name_english,

    MAX(f.price) AS highest_price,

    ROUND(SUM(f.total_amount),2) AS revenue

FROM mart.fact_sales f

JOIN mart.dim_product p
ON f.product_key = p.product_key

GROUP BY
    p.product_id,
    p.product_category_name_english

ORDER BY highest_price DESC

LIMIT 20;

-- Average Order Value by Payment Type

SELECT

    payment_type,

    ROUND(AVG(total_amount),2) AS average_order_value,

    ROUND(SUM(total_amount),2) AS revenue

FROM mart.fact_sales

GROUP BY payment_type

ORDER BY revenue DESC;