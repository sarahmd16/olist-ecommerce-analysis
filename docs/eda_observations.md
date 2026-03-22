# Exploratory Data Analysis (EDA) Observations

## Executive Summary
Analysis of the Olist e-commerce dataset (Sept 2016 – Aug 2018) reveals a rapidly growing marketplace with strong seasonality, high geographic concentration in Southeast Brazil, and a dominant credit card payment preference. Notably, logistics performance is exceptionally efficient (early deliveries), while customer repeat purchase rates appear negligible in this specific filtered dataset.

## 1. Temporal Trends: Strong Growth & Seasonality
- **Growth Trajectory:** The business shows consistent month-over-month growth from late 2016 through early 2018.
- **Peak Season:** A massive spike occurred in **November 2017** (Black Friday/Cyber Monday period), recording:
  - **7,288 orders** (highest volume).
  - **~$987K revenue** (highest monthly total).
- **Stabilization:** Post-holiday, volumes stabilized around 6,000–7,000 orders/month in 2018, indicating a new, higher baseline compared to 2017.
- **Average Order Value (AOV):** Remains relatively stable between **$109 – $132**, suggesting consistent pricing power regardless of volume spikes.

## 2. Geographic Insights: Heavy Regional Concentration
- **Market Dominance:** The state of **São Paulo (SP)** is the undisputed leader, accounting for:
  - **40,501 orders** (~42% of total analyzed volume).
  - **$5.06M revenue**.
- **Top 3 States:** SP, Rio de Janeiro (RJ), and Minas Gerais (MG) combined represent the vast majority of revenue, reflecting Brazil's economic center in the Southeast.
- **AOV Variation:** While SP has the highest volume, **Bahia (BA)** has the highest Average Order Value (**$134.02**), suggesting customers in this region may purchase higher-value items or larger baskets.

## 3. Payment Behavior: Credit Card Dominance
- **Primary Method:** **Credit Cards** are the overwhelming preference:
  - **74,304 transactions** (~77% of usage).
  - **$12.1M total value** (~81% of revenue).
- **Higher Spend:** Credit card users have a significantly higher average transaction value (**$162.24**) compared to Boleto (**$144.33**) or Vouchers (**$62.45**).
- **Strategic Insight:** Promoting credit card payments could increase average basket size. Vouchers are used frequently but drive low value.

## 4. Operational Health: Exceptional Logistics Performance
- **Delivery Speed:** Contrary to typical e-commerce challenges, deliveries are **ahead of schedule**.
  - **Average Delay:** **-11.18 days** (Negative value indicates early delivery).
  - **Interpretation:** On average, packages arrive **11 days earlier** than the estimated date.
- **Late Rate:** Only **7,826 out of 96,470** orders (~8.1%) were delivered late.
- **Business Impact:** This high reliability likely contributes to high customer satisfaction, though we must verify if "estimated dates" are conservatively padded.

## 5. Customer Behavior: Zero Repeat Purchases Detected?
- **Finding:** The analysis shows **0 repeat customers** (0.00% repeat rate) among the 96,478 unique customers.
- **Critical Interpretation:** 
  - *Hypothesis A:* The dataset timeframe (2 years) might be too short for significant repurchase cycles in this specific category mix.
  - *Hypothesis B (More Likely):* The `customer_unique_id` logic or data filtering (`order_status = 'delivered'`) might be isolating single transactions per user in this specific view. 
  - *Action Item:* In Phase 5 (Core Analysis), we must re-examine the `customer_unique_id` vs `customer_id` relationship to ensure we aren't inadvertently filtering out returning users. If accurate, this indicates a critical **retention problem** requiring immediate marketing intervention.

## Next Steps for Core Analysis (Phase 5)
Based on these findings, the next phase will focus on:
1.  **RFM Segmentation:** Despite the low repeat rate, we will segment users by Recency and Monetary value to identify "High Potential" one-time buyers.
2.  **Logistics Deep Dive:** Investigate *why* deliveries are so early (is it carrier efficiency or conservative estimation?) and correlate early delivery with **Review Scores**.
3.  **Category Profitability:** Drill down into *which* product categories drive the high AOV in Bahia (BA) vs. São Paulo (SP).
4.  **Data Validation:** Re-verify the "0 repeat customers" metric by analyzing the raw `customers` table join logic.