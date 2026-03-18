# Project Brief: Olist E-Commerce Performance Analysis

## 🎯 Problem Statement
The goal is to uncover actionable insights that improve **customer retention**, **seller performance**, and **operational efficiency** using historical transactional data (2016-2018).

## 🔑 Business Questions & Associated KPIs

| Business Question | Primary KPI(s) | Analytical Approach |
|------------------|----------------|---------------------|
| **1. What drives customer satisfaction and repeat purchases?** | - Review score average<br>- Repeat purchase rate<br>- Net Promoter Score (proxy) | Cohort analysis, correlation between review scores & retention, sentiment proxy via review text |
| **2. How do delivery performance and logistics impact order outcomes?** | - On-time delivery rate<br>- Delivery time variance<br>- Cancellation rate by shipping delay | Time-to-delivery analysis, JOIN orders + geolocation + order_items, outlier detection on shipping times |
| **3. Which product categories and sellers generate the highest value?** | - Revenue by category<br>- Seller GMV (Gross Merchandise Value)<br>- Category-level conversion rate | RFM-style segmentation, GROUP BY aggregations, window functions for seller ranking |
| **4. Are there geographic patterns in customer behavior or operational bottlenecks?** | - Orders per state/region<br>- Average delivery time by distance<br>- Regional cancellation rates | Geospatial grouping (customer/seller location), distance approximation, regional trend analysis |
| **5. How do payment methods correlate with order value and completion?** | - Average order value by payment type<br>- Payment method adoption rate<br>- Failed payment incidence | Payment table analysis, conditional aggregations, fraud/risk proxy identification |

## 📐 Analysis Scope

### ✅ In Scope
- Timeframe: Orders from **2016-09-01 to 2018-10-17** (full dataset range)
- Focus entities: Customers, orders, order_items, products, sellers, payments, reviews
- Geographic analysis: Brazilian states (via `geolocation` table)
- Metrics: Revenue, delivery performance, customer satisfaction, seller performance

## 🎯 Success Criteria
- [ ] Deliver **3-5 data-backed insights** with quantified business impact
- [ ] Produce **reproducible, modular SQL scripts** using CTEs and window functions
- [ ] Document data assumptions, limitations, and validation steps
- [ ] Package analysis in a clean GitHub repo with professional README

## 🛠️ Tools & Tech Stack
- **Database**: PostgreSQL (local or AWS RDS)
- **Analysis**: SQL (CTEs, window functions, complex JOINs)
- **Documentation**: Markdown (GitHub), ERD via dbdiagram.io or Lucidchart

