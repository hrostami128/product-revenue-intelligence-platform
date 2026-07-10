/*==============================================================
11_customer_analytics.sql

Project:
Product & Revenue Intelligence Platform

Purpose:
Customer Analytics

Layer:
Mart

==============================================================*/
-- Customer Distribution by State

SELECT

    customer_state,

    COUNT(*) AS total_customers

FROM mart.dim_customer

GROUP BY customer_state

ORDER BY total_customers DESC;


-- Revenue by Customer State

SELECT

    c.customer_state,

    ROUND(SUM(f.total_amount),2) AS revenue

FROM mart.fact_sales f

JOIN mart.dim_customer c
ON f.customer_key = c.customer_key

GROUP BY c.customer_state

ORDER BY revenue DESC;

-- Top Customers

SELECT

    c.customer_unique_id,

    ROUND(SUM(f.total_amount),2) AS revenue,

    COUNT(DISTINCT f.order_id) AS total_orders

FROM mart.fact_sales f

JOIN mart.dim_customer c
ON f.customer_key = c.customer_key

GROUP BY c.customer_unique_id

ORDER BY revenue DESC

LIMIT 20;

-- Customers with More Than One Order

SELECT

    c.customer_unique_id,

    COUNT(DISTINCT f.order_id) AS total_orders,

    ROUND(SUM(f.total_amount),2) AS revenue

FROM mart.fact_sales f

JOIN mart.dim_customer c
ON f.customer_key = c.customer_key

GROUP BY c.customer_unique_id

HAVING COUNT(DISTINCT f.order_id) > 1

ORDER BY total_orders DESC;

-- Payment Type Distribution

SELECT

    payment_type,

    COUNT(*) AS total_orders,

    ROUND(SUM(total_amount),2) AS revenue

FROM mart.fact_sales

GROUP BY payment_type

ORDER BY revenue DESC;

-- Review Score Distribution

SELECT

    review_score,

    COUNT(*) AS total_orders,

    ROUND(AVG(total_amount),2) AS average_order_value

FROM mart.fact_sales

GROUP BY review_score

ORDER BY review_score;

