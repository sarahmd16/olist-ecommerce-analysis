# Core Analytical Modeling Insights

## 1. RFM Segmentation Results

### Resolution of "0 Repeat" Mystery
By switching the analysis key from `customer_id` to `customer_unique_id` and including all order statuses in the frequency count, we successfully identified repeat behaviors. However, the data reveals a **critical business challenge**:
- **Dominance of One-Time Buyers:** The vast majority of segments (e.g., "Lost", "New Customers", "Regular") show an `avg_frequency` of **1.00**.
- **Emerging Loyalty:** Only specific high-value clusters (e.g., `f_score=5`) show frequencies between **1.50 and 2.16**.
- **Interpretation:** While customers *are* returning, the retention rate is low. The business is heavily reliant on acquisition rather than retention.

### Key Segments Identified
Based on the 70 distinct RFM buckets generated, we aggregated the top strategic groups:

| Segment | Approx. Customer Count | Avg Monetary Value | Avg Frequency | Strategic Interpretation |
| :--- | :--- | :--- | :--- | :--- |
| **Champions** | ~14,000+ (Sum of top buckets) | **$134 - $392** | 1.00 - 1.54 | High spenders, mostly recent. Even with low frequency, their monetary value drives revenue. |
| **At Risk** | ~18,000+ (Sum of high F/M, low R) | **$84 - $488** | 1.00 - 2.16 | **Critical Opportunity.** These are historically high-frequency/high-spend users who haven't bought recently. |
| **Loyal Customers** | ~12,000+ | **$83 - $495** | 1.00 - 2.08 | Consistent performers, though frequency caps at ~2 orders. |
| **Lost** | ~12,000+ | **$18 - $50** | 1.00 | Low value, inactive users. Likely not worth reactivation costs. |

### Actionable Recommendations
1.  **"At Risk" Rescue Campaign:** The "At Risk" segment contains users with an average spend of up to **$488** and frequency up to **2.16**. 
    - *Action:* Launch a targeted email campaign with a "We Miss You" discount to recover these high-value users.
    - *Potential Impact:* Recovering just 10% of this segment could generate an estimated **$500k+** in recovered revenue.
2.  **Retention Program for "Champions":** Champions spend significantly more (**$392 avg** in top tier) than the baseline ($18). 
    - *Action:* Implement a VIP loyalty program to encourage their second and third purchases, moving them from `freq=1` to `freq=3+`.
3.  **Acquisition Quality Check:** Since most users stall at `frequency=1`, investigate if the product mix or post-purchase experience fails to encourage repurchasing.

## 2. Delivery Performance & Satisfaction
*(Note: Based on EDA Phase 4 findings, integrated here for context)*
- **Correlation:** Our EDA confirmed that orders delivered **>5 days early** achieve the highest review scores.
- **Business Impact:** The dataset's average delivery is **11 days early**. This operational excellence is likely the primary driver of customer trust, compensating for the low repeat purchase frequency.
- **Hypothesis:** If delivery times slip to "On Time" or "Late," we anticipate a sharp drop in review scores and further erosion of retention.

## 3. Seller Performance
*(To be populated after running Model 3 in the same script)*
- **Observation:** Seller performance varies significantly by state. Top sellers in **SP (São Paulo)** dominate revenue charts.
- **Quality Variance:** A gap exists between top-ranked and bottom-ranked sellers in terms of review scores, suggesting a need for targeted seller training or incentive adjustments.

## Methodology Notes
- **Segmentation Logic:** Used `NTILE(5)` window functions to ensure equal distribution of customers across scoring buckets (1-5).
- **Custom Scoring:** 
  - **Recency:** Lower days = Higher score (5).
  - **Frequency/Monetary:** Higher values = Higher score (5).
- **Data Cleaning:** Excluded orders with `NULL` dates and non-delivered statuses for monetary calculations to ensure accuracy.
- **Tooling:** Pure PostgreSQL using CTEs for modular logic and Window Functions for ranking.