/*==============================================================
10_business_kpi_queries.sql
Project: Product & Revenue Intelligence Platform
==============================================================*/

-- 1. Total Revenue
SELECT ROUND(SUM(total_amount),2) AS total_revenue
FROM mart.fact_sales;

-- 2. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM mart.fact_sales;

-- 3. Total Customers
SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM mart.fact_sales;

-- 4. Total Quantity Sold
SELECT SUM(order_item_id) AS total_order_items
FROM mart.fact_sales;

-- 5. Average Order Value
SELECT ROUND(SUM(total_amount)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM mart.fact_sales;

-- 6. Revenue per Customer
SELECT ROUND(SUM(total_amount)/COUNT(DISTINCT customer_key),2) AS revenue_per_customer
FROM mart.fact_sales;

-- 7. Average Freight per Order
SELECT ROUND(SUM(freight_value)/COUNT(DISTINCT order_id),2) AS avg_freight_per_order
FROM mart.fact_sales;

-- 8. Freight Percentage
SELECT
ROUND(SUM(freight_value),2) AS total_freight,
ROUND(SUM(total_amount),2) AS total_revenue,
ROUND(SUM(freight_value)/SUM(total_amount)*100,2) AS freight_percentage
FROM mart.fact_sales;

-- 9. Revenue by Year
SELECT d.year,
ROUND(SUM(f.total_amount),2) AS revenue
FROM mart.fact_sales f
JOIN mart.dim_date d
ON f.date_key=d.date_key
GROUP BY d.year
ORDER BY d.year;

-- 10. Revenue by Month
SELECT d.year,d.month,d.month_name,
ROUND(SUM(f.total_amount),2) AS revenue
FROM mart.fact_sales f
JOIN mart.dim_date d
ON f.date_key=d.date_key
GROUP BY d.year,d.month,d.month_name
ORDER BY d.year,d.month;

-- 11. Revenue by State
SELECT c.customer_state,
ROUND(SUM(f.total_amount),2) AS revenue
FROM mart.fact_sales f
JOIN mart.dim_customer c
ON f.customer_key=c.customer_key
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- 12. Top Product Categories
SELECT
p.product_category_name_english,
ROUND(SUM(f.total_amount),2) AS revenue,
COUNT(*) AS order_items
FROM mart.fact_sales f
JOIN mart.dim_product p
ON f.product_key=p.product_key
GROUP BY p.product_category_name_english
ORDER BY revenue DESC;

-- 13. Seller Revenue
SELECT
s.seller_state,
ROUND(SUM(f.total_amount),2) AS revenue
FROM mart.fact_sales f
JOIN mart.dim_seller s
ON f.seller_key=s.seller_key
GROUP BY s.seller_state
ORDER BY revenue DESC;

-- 14. Review Score Distribution
SELECT review_score,COUNT(*) AS orders
FROM mart.fact_sales
GROUP BY review_score
ORDER BY review_score;
