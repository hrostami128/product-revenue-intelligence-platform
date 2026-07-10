-- =====================================================
-- RAW DATA QUALITY CHECKS
-- =====================================================

-- Duplicate Customers
SELECT customer_id, COUNT(*)
FROM raw.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Duplicate Orders
SELECT order_id, COUNT(*)
FROM raw.orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Duplicate Products
SELECT product_id, COUNT(*)
FROM raw.products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Duplicate Sellers
SELECT seller_id, COUNT(*)
FROM raw.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;