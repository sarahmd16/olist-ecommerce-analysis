# Executive Summary: Olist E-Commerce Performance Analysis

## 🎯 Project Objective
To analyze historical transactional data (2016-2018) from Olist, a Brazilian e-commerce marketplace, to identify drivers of revenue, customer retention opportunities, and operational efficiencies.

## 🔑 Top 3 Strategic Recommendations

### 1. Launch a High-Value "At Risk" Recovery Campaign
*   **Insight:** Our RFM analysis identified ~18,000 customers in the "At Risk" segment. These users have historically high monetary value (**avg. $84–$488**) and frequency (**up to 2.16 orders**), but have not purchased recently.
*   **Business Impact:** Recovering just **10%** of this segment could generate an estimated **$500k+** in immediate revenue.
*   **Action:** Deploy a targeted email/SMS campaign with a personalized "We Miss You" discount code specifically for users with `monetary_score >= 4` and `recency_score <= 2`.

### 2. Leverage Logistics Excellence as a Marketing Asset
*   **Insight:** Olist delivers orders **11 days earlier than estimated** on average. This exceptional performance correlates with high customer trust, yet it is not being actively marketed.
*   **Business Impact:** In a market where delivery speed is a top purchase driver, this is a unique selling proposition (USP).
*   **Action:** Update product pages and checkout flows to highlight "Average Delivery: 11 Days Early!" instead of conservative estimates. This could improve conversion rates and justify premium shipping options.

### 3. Address the "One-and-Done" Customer Retention Gap
*   **Insight:** Despite high satisfaction, **~85% of customers have only purchased once** (`avg_frequency` = 1.0 for most segments). The business is overly reliant on new customer acquisition.
*   **Business Impact:** Increasing repeat purchase rate by just 5% could significantly lower Customer Acquisition Cost (CAC) and increase Lifetime Value (LTV).
*   **Action:** 
    *   Implement a post-purchase email sequence (Day 7, Day 21, Day 45) suggesting complementary products based on category history.
    *   Introduce a loyalty points program that rewards the **second purchase** specifically, breaking the "one-time" barrier.

## 📊 Key Metrics Dashboard (Snapshot)
| Metric | Value | Trend/Status |
| :--- | :--- | :--- |
| **Total Analyzed Revenue** | ~$12.4M | Strong Growth (2016-2018) |
| **Peak Month** | Nov 2017 ($987K) | Seasonal Spike (Black Friday) |
| **Top Region** | São Paulo (SP) | 42% of Total Revenue |
| **Avg Delivery Delay** | -11.18 Days | ⭐ Operational Excellence |
| **Repeat Customer Rate** | <15% | ⚠️ Critical Area for Improvement |
| **Dominant Payment** | Credit Card (77%) | Higher Avg. Order Value ($162) |

## 🛠️ Methodology & Tools
*   **Data Stack:** PostgreSQL (Window Functions, CTEs, Complex Joins), Docker (Containerization).
*   **Analysis Techniques:** RFM Segmentation, Cohort Logic, Time-Series Trending, Correlation Analysis.
*   **Validation:** Rigorous data profiling (null checks, logical anomaly detection) ensured 99%+ data integrity before modeling.

## 📁 Project Artifacts
*   `sql/01_data_profiling.sql`: Data quality validation scripts.
*   `sql/02_eda_queries.sql`: Exploratory trend analysis.
*   `sql/03_core_analysis.sql`: Advanced RFM & Seller Ranking models.
*   `docs/quality_report.md`: Detailed data health assessment.
*   `docs/eda_observations.md`: Initial trend findings.
*   `docs/core_analysis_insights.md`: Deep dive into segmentation.

---
*Prepared by: Sarra Hammouda | Date: March 2026*