# Star Schema Design

## Objective

Design an analytical Star Schema optimized for business intelligence, reporting, and advanced analytics.

The analytical model is built on business requirements rather than the raw source structure.

---

# Fact Table

## fact_sales

### Grain

One row represents one product sold by one seller within one customer order.

### Business Process

Sales Transaction

### Measures

- price
- freight_value

### Foreign Keys

- order_key
- customer_key
- product_key
- seller_key
- order_date_key

---

# Dimension Tables

## dim_customer

Source:
customers

Business Key:
customer_id

---

## dim_product

Source:
products

Business Key:
product_id

---

## dim_seller

Source:
sellers

Business Key:
seller_id

---

## dim_category

Source:
category_translation

Business Key:
product_category_name

---

## dim_date

Generated during ETL.

---

# Supporting Fact Tables

## fact_payment

Business Process:
Payment Transaction

---

## fact_review

Business Process:
Customer Review