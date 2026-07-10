# Product & Revenue Intelligence Platform

An end-to-end Business Intelligence project built on the Olist E-commerce dataset. The project follows a layered data warehouse architecture using PostgreSQL and delivers interactive business insights through Power BI dashboards.

The objective was not only to build dashboards, but to design a complete analytics workflow—from raw data ingestion to business-ready reporting.

---

## Project Objectives

* Design a PostgreSQL data warehouse using a Star Schema.
* Build a layered ETL process (Raw → Staging → Mart).
* Create reusable SQL views for reporting.
* Develop interactive Power BI dashboards for business users.
* Document the entire analytics workflow.

---

## Dataset

**Source:** Olist Brazilian E-commerce Public Dataset

The dataset contains information about:

* Customers
* Orders
* Order Items
* Products
* Sellers
* Payments
* Reviews
* Geolocation
* Product Categories

---

## Project Architecture

```text
Raw CSV Files
        │
        ▼
 Staging Layer
        │
        ▼
 Data Warehouse (Star Schema)
        │
        ▼
 Reporting Views
        │
        ▼
 Power BI Dashboard
```

---

## Data Warehouse

The warehouse was designed using a Star Schema.

### Fact Table

* fact_sales

### Dimension Tables

* dim_customer
* dim_product
* dim_seller
* dim_date

Grain:

> One row represents one order item.

---

## ETL Process

The ETL pipeline loads raw CSV files into the staging layer before transforming the data into dimensional tables.

The process includes:

* Data cleaning
* Data type conversion
* Key generation
* Dimension loading
* Fact loading
* Validation queries

---

## SQL Analytics

Business-oriented SQL scripts were developed for:

* Executive KPIs
* Customer Analytics
* Product Analytics
* Seller Analytics

Reporting views were also created to simplify Power BI development.

---

## Power BI Dashboard

The dashboard consists of four business-focused pages:

### Executive Dashboard

Provides a high-level overview of business performance through key KPIs and revenue trends.

### Customer Analytics

Explores customer distribution, purchasing behavior, and top customers.

### Product Analytics

Analyzes product categories, revenue contribution, pricing metrics, and product performance.

### Seller Analytics

Evaluates seller performance, regional distribution, and sales contribution.

---

## Repository Structure

```text
product-revenue-intelligence-platform/
│
├── data/
├── database/
├── docs/
├── notebooks/
├── powerbi/
├── screenshots/
├── README.md
├── requirements.txt
└── LICENSE
```
### Dataset Download

The original dataset is not included in this repository due to GitHub file size limitations.

You can download the dataset from the following source:

**Olist Brazilian E-commerce Public Dataset**

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

After downloading, place the CSV files inside the following directory:

```text
data/raw/
```

The project was developed using the original Olist dataset without structural modifications.

---

## Technologies Used

* PostgreSQL
* SQL
* Power BI
* Python
* Pandas
* NumPy
* SQLAlchemy
* Jupyter Notebook

---

## Project Documentation

The repository includes:

* Data Dictionary
* Data Model
* Business Requirements
* Business Insights
* Future Improvements
* Known Limitations

---

## Future Improvements

Possible enhancements include:

* Incremental ETL
* Power BI Service deployment
* Row-Level Security (RLS)
* Automated data quality checks
* Sales forecasting using Python
* CI/CD pipeline for database scripts

---

## Screenshots

Dashboard previews are available in the **screenshots** folder.

---

## How to Run

1. Clone the repository.
2. Create the PostgreSQL schemas.
3. Execute the SQL scripts in the `database` folder in numerical order.
4. Open the Power BI file.
5. Refresh the data source.

---

## Author

**Hossein Rostami**

Industrial Engineer | Data Analyst | Business Intelligence

GitHub:
https://github.com/hrostami128

LinkedIn:
https://linkedin.com/in/hossein-rostami-baa9a0211

