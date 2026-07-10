# Enterprise Data Dictionary

## Overview

This document provides business definitions for each source table used in the Product & Revenue Intelligence Platform.

Detailed column metadata (data types, null counts, unique values, etc.) is automatically generated during the data profiling phase and stored in:

`data/processed/column_metadata.csv`

---

## customers

### Business Description

Stores customer master data.

### Business Grain

One row represents one customer record.

### Candidate Primary Key

customer_id

### Business Notes

- customer_unique_id represents the same customer across multiple purchases.
- customer_id identifies a specific customer record used in orders.

---

## orders

### Business Description

Stores order lifecycle information.

### Business Grain

One row represents one order.

### Candidate Primary Key

order_id

### Foreign Keys

customer_id

### Business Notes

Contains order status and important lifecycle timestamps.

---

## order_items

### Business Description

Stores every purchased item within an order.

### Business Grain

One row represents one product sold within one order.

### Candidate Primary Key

(order_id, order_item_id)

### Foreign Keys

- order_id
- product_id
- seller_id

### Business Notes

This table is the primary transactional source for sales analytics.

---

## payments

### Business Description

Stores payment information for each order.

### Business Grain

One payment transaction within an order.

### Candidate Primary Key

(order_id, payment_sequential)

---

## reviews

### Business Description

Stores customer reviews associated with completed orders.

### Business Grain

One review record linked to an order.

### Candidate Primary Key

(review_id, order_id)

### Business Notes

review_id is not globally unique and must be combined with order_id.

---

## products

### Business Description

Stores product master information.

### Business Grain

One row represents one product.

### Candidate Primary Key

product_id

---

## sellers

### Business Description

Stores seller master data.

### Business Grain

One row represents one seller.

### Candidate Primary Key

seller_id

---

## category_translation

### Business Description

Maps Portuguese product categories to English.

### Business Grain

One row represents one product category.

### Candidate Primary Key

product_category_name

---

## geolocation

### Business Description

Stores geographic reference information based on ZIP codes.

### Business Grain

Multiple geographic coordinates may exist for the same ZIP code.

### Candidate Primary Key

No suitable primary key identified.

### Business Notes

This table contains duplicated records and will be evaluated during the ETL phase.