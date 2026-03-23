# 🛒 Olist E-Commerce Performance Analysis
### *SQL-Driven Insights for Customer Retention & Operational Efficiency*

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat&logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📖 Overview
This project performs a data analysis on the **Olist Brazilian E-Commerce Dataset** (100k+ orders, 2016-2018). The analysis focuses on understanding customer behavior, improving retention, and identifying operational patterns using SQL.


---


## 🛠️ Tech Stack & Methodologies
| Category | Tools & Techniques |
| :--- | :--- |
| **Database** | PostgreSQL 16 (CTEs, Window Functions, Complex Joins) |
| **Infrastructure** | Docker & Docker Compose (Reproducible Environment) |
| **Analysis** | RFM Segmentation, Cohort Logic, Time-Series Trending |
| **Data Quality** | Automated Profiling (Null checks, Anomaly Detection) |
| **Automation** | Bash Scripting for Data Ingestion |
| **Documentation** | Markdown, ERD Diagrams, Data Dictionaries |

---

## 📂 Repository Structure
- `/data` — Raw CSV datasets (gitignored)
- `/sql` — Modular, reproducible SQL scripts
  - `00_schema_setup.sql` — Database schema & constraints
  - `01_data_profiling.sql` — Data quality validation
  - `02_eda_queries.sql` — Exploratory Data Analysis
  - `03_core_analysis.sql` — RFM Modeling & Rankings
- `/docs` — Detailed reports & documentation
  - `project_brief.md` — Scope & KPIs
  - `data_dictionary.md` — Schema definitions
  - `quality_report.md` — Data health findings
  - `eda_observations.md` — Trend analysis
  - `core_analysis_insights.md` — Segmentation deep-dive
  - `INSIGHTS_SUMMARY.md` — Executive summary
- `/outputs` — Exported CSV results
- `docker-compose.yml` — Container orchestration
- `load_data.sh` — Automation script for data ingestion
- `README.md` — This file



---

## 🚀 How to Reproduce This Analysis
This project is fully containerized using **Docker** to ensure reproducibility across any environment. Follow these steps to run the analysis locally.

### Prerequisites
- **Docker** and **Docker Compose** installed on your machine.
- The **9 Olist dataset CSV files** downloaded and placed inside the local `/data` folder.
Dataset: [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/olistbr/brazilian-ecommerce)

### Step 1: Start the Database
Spin up the PostgreSQL container using Docker Compose:
```bash
docker compose up -d
```

### Step 2: Create the Database Schema
Run the schema setup script to create tables with proper constraints (Primary/Foreign Keys):

```bash
docker exec -i olist-postgres psql -U postgres -d olist_db < sql/00_schema_setup.sql
```

### Step 3: Ingest the Data
Load the CSV files into the database. Since the `/data` folder is mounted to `/var/data` inside the container, we use PostgreSQL’s `\copy` command via `docker exec`.

Run the following commands from your **local terminal (outside the container)**:

```bash
# 1. Customers
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy customers FROM '/var/data/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;"

# 2. Geolocation
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy geolocation FROM '/var/data/olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;"

# 3. Sellers
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy sellers FROM '/var/data/olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;"

# 4. Products
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy products FROM '/var/data/olist_products_dataset.csv' DELIMITER ',' CSV HEADER;"

# 5. Product Category Translation
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy product_category_name_translation FROM '/var/data/product_category_name_translation.csv' DELIMITER ',' CSV HEADER;"

# 6. Orders
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy orders FROM '/var/data/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;"

# 7. Order Items
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy order_items FROM '/var/data/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;"

# 8. Order Payments
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy order_payments FROM '/var/data/olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;"

# 9. Order Reviews
docker exec -i olist-postgres psql -U postgres -d olist_db -c "\copy order_reviews FROM '/var/data/olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;"
```

### (Optional) Automate the Ingestion
To streamline the workflow, you can automate the above commands using a shell script:

```bash
chmod +x load_data.sh
./load_data.sh
```

### Step 4: Verify the Ingestion
Quickly validate that the data loaded correctly:

```sql
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM order_items;
```

If counts are greater than 0 (and roughly match dataset expectations), the ingestion was successful.
### Step 5: Run the Analysis
Execute the analysis scripts in order. You can run them individually or all at once.

**Quality Check:**
```bash
docker exec -i olist-postgres psql -U postgres -d olist_db -f /var/sql/01_data_profiling.sql
```

**Exploratory Data Analysis (EDA):**
```bash
docker exec -i olist-postgres psql -U postgres -d olist_db -f /var/sql/02_eda_queries.sql
```

**Core Modeling (RFM Segmentation & Seller Ranking):**
```bash
docker exec -i olist-postgres psql -U postgres -d olist_db -f /var/sql/03_core_analysis.sql
```

### Step 6: Analyze & Document Results
The query outputs will be printed directly in your terminal.

At this stage, interpret the results and document your findings:

- Data Quality → `docs/quality_report.md`
- EDA Insights → `docs/eda_observations.md`
- Core Modeling Insights → `docs/core_analysis_insights.md`


```
