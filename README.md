# 🛒 Olist E-Commerce Performance Analysis
### *SQL-Driven Insights for Customer Retention & Operational Efficiency*

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat&logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📖 Overview
This project performs an end-to-end data analysis on the **Olist Brazilian E-Commerce Dataset** (100k+ orders, 2016-2018). Leveraging skills in **Data Analysis**, **DevOps**, and **Backend Engineering**, this project moves beyond simple reporting to deliver **actionable business strategies** for improving customer retention and leveraging operational strengths.

**Key Achievement:** Identified a **$500k+ revenue recovery opportunity** by segmenting "At Risk" high-value customers using advanced SQL window functions and RFM modeling.

---

## 💡 Key Business Insights
1.  **Revenue Recovery Opportunity:** ~18,000 "At Risk" customers (high spend, low recency) were identified. A targeted reactivation campaign could recover significant revenue.
2.  **Logistics as a USP:** Orders are delivered **11 days early** on average. This operational excellence is currently under-utilized in marketing messaging.
3.  **Retention Gap:** 85% of customers are one-time buyers. The business model is heavily acquisition-dependent, signaling a need for a structured loyalty program.

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
  - Files needed: `olist_customers_dataset.csv`, `olist_orders_dataset.csv`, `olist_order_items_dataset.csv`, etc.

### Step 1: Start the Database
Spin up the PostgreSQL container using Docker Compose:
```bash
docker compose up -d

### Step 2: Create the Database Schema
Run the schema setup script to create tables with proper constraints (Primary/Foreign Keys):
```bash
docker exec -i olist-postgres psql -U postgres -d olist_db < sql/00_schema_setup.sql

### Step 3: Ingest the Data
Use the automated bash script to load all 9 CSV files into the database. This script handles the mapping between local files and the container paths:
# Make the script executable
chmod +x load_data.sh

# Run the ingestion
./load_data.sh

### Step 4: Run the Analysis
Execute the analysis scripts in order. You can run them individually or all at once.

Quality Check:
docker exec -i olist-postgres psql -U postgres -d olist_db -f /var/sql/01_data_profiling.sql

Exploratory Data Analysis (EDA):
docker exec -i olist-postgres psql -U postgres -d olist_db -f /var/sql/02_eda_queries.sql

Core Modeling (RFM Segmentation & Seller Ranking):
docker exec -i olist-postgres psql -U postgres -d olist_db -f /var/sql/03_core_analysis.sql

### Step 5: View Results
The output will be printed directly to your terminal. For persistent results, you can modify the scripts to export to CSV using the \copy command into the /var/data/outputs directory.