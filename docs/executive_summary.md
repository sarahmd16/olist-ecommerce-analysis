# 📊 Executive Summary: Olist E-Commerce Analysis
**Prepared by:** Sarra Hammouda  
**Date:** March 2026  
**Dataset:** 100K+ orders | 9 relational tables | PostgreSQL 16 + Docker  

---

## 🎯 Business Questions & Key Findings

### 1. What drives customer satisfaction and repeat purchases?
| Insight | Metric | Business Implication |
|---------|--------|---------------------|
| **Early deliveries boost satisfaction** | Avg. delay: **-11.18 days** (early) | Logistics reliability is a key satisfaction driver |
| **Repeat purchases are rare** | 96,478 unique customers; **0% repeat rate** in raw EDA | Suggests retention challenge or limited dataset time window |
| **High-value "At Risk" segment identified** | ~18,000 customers; **$488 avg. spend** | Targeted reactivation campaigns could recover ~$8.8M in potential revenue |

### 2. How do delivery performance and logistics impact order outcomes?
| Insight | Metric | Business Implication |
|---------|--------|---------------------|
| **Most deliveries arrive early** | 7,826 late deliveries (~8% of total) | Opportunity to optimize "just-in-time" delivery to reduce costs |
| **Late deliveries correlate with lower reviews** | Qualitative SQL correlation confirmed | Prioritize on-time delivery for high-value orders to protect brand reputation |

### 3. Which product categories and sellers generate the highest value?
| Insight | Metric | Business Implication |
|---------|--------|---------------------|
| **Southeast sellers dominate revenue** | SP alone: **$5.06M (42% of total)** | Regional supply chain concentration = efficiency + risk |
| **High-frequency ≠ high-value categories** | Volume leaders: `bed_bath_table`; Value leaders: `electronics` | Tailor marketing/promotions by category strategy (volume vs. margin) |

### 4. Are there geographic patterns in customer behavior or operational bottlenecks?
| Insight | Metric | Business Implication |
|---------|--------|---------------------|
| **Customer concentration in Southeast** | Top 3 states (SP, RJ, MG): **~65% of orders** | Infrastructure investments should prioritize these regions |
| **November spike stresses logistics** | Peak month: **7,288 orders** (Black Friday effect) | Pre-peak capacity planning essential to maintain service levels |

### 5. How do payment methods correlate with order value and completion?
| Payment Method | Usage | Avg. Transaction Value | Strategic Insight |
|---------------|-------|----------------------|------------------|
| 💳 Credit Card | 74,304 | **$162.24** | Preferred for high-value orders; prioritize UX for this flow |
| 🧾 Boleto | 19,191 | $144.33 | Popular but lower basket; consider incentives to upsell |
| 🎟️ Voucher | 3,679 | **$62.45** | Likely promotional; monitor for margin impact |
| 💳 Debit Card | 1,485 | $140.26 | Niche usage; low priority for optimization |

---

## 🚀 Top 3 Strategic Recommendations

1. **Launch a "Win-Back" Campaign for At-Risk High-Value Customers**  
   Target the ~18K customers segmented as "At Risk" with $488+ avg. spend. Personalized offers could recover significant revenue with minimal CAC.

2. **Optimize Logistics for On-Time (Not Early) Delivery**  
   While early deliveries boost satisfaction, they may indicate over-buffered timelines. Refine forecasting to reduce warehousing costs while maintaining >95% on-time rate.

3. **Diversify Seller Base Beyond Southeast Brazil**  
   Reduce operational risk by incentivizing seller onboarding in underrepresented regions (North/Northeast), unlocking new customer segments and improving delivery resilience.

---

## 🔍 Methodology & Technical Highlights
- **Pipeline:** Reproducible ETL via Docker + PostgreSQL; modular SQL scripts (`00_schema_setup.sql` → `03_core_analysis.sql`)
- **Analysis:** Data profiling, EDA with `DATE_TRUNC`/`GROUP BY`, RFM segmentation using `NTILE` window functions
- **Validation:** Null/duplicate checks, logical date validation, business rule enforcement (e.g., only "delivered" orders for revenue calc)
- **Documentation:** All queries, findings, and assumptions version-controlled in GitHub for transparency

---

> 💡 **Critical Reflection**: *The 0% repeat-customer finding initially appeared anomalous. Further investigation revealed it stemmed from using `customer_id` (order-level) instead of `customer_unique_id` (person-level) in early queries. This underscores the importance of schema literacy and iterative validation in analytics—a lesson applied throughout this project.*

---

**🔗 Project Repository**: [github.com/yourusername/olist-ecommerce-analysis]  
**📧 Contact**: sarrahammouda.contact@gmail.com | [LinkedIn] | [GitHub]