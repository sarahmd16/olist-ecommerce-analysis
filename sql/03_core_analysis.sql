-- 03_core_analysis.sql
-- Purpose: Build RFM Segmentation Model and Delivery-Satisfaction Correlation.
-- Author: Sarra Hammouda
-- Date: March 2026

-- ==========================================================
-- MODEL 1: RFM SEGMENTATION (Recency, Frequency, Monetary)
-- ==========================================================
-- Goal: Segment customers into actionable groups (e.g., Champions, At Risk).
-- Note: Using customer_unique_id to capture full history across all orders.

WITH rfm_calc AS (
    SELECT 
        c.customer_unique_id,
        -- Recency: Days since last order (as of max date in dataset)
        MAX(o.order_purchase_timestamp) AS last_order_date,
        DATE_TRUNC('day', (SELECT MAX(order_purchase_timestamp) FROM orders)) - MAX(o.order_purchase_timestamp) AS recency_days,
        -- Frequency: Total number of orders
        COUNT(DISTINCT o.order_id) AS frequency,
        -- Monetary: Total spend on delivered orders only
        SUM(CASE WHEN o.order_status = 'delivered' THEN oi.price ELSE 0 END) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT 
        *,
        -- NTILE(5) divides customers into 5 equal groups 
        -- 1=Best (most recent), 5=Worst for Recency
        -- 1=Worst (lowest freq/monetary), 5=Best for F/M
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_calc
)
SELECT 
    r_score, 
    f_score, 
    m_score,
    -- Define the segment label based on scores
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customers'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2 THEN 'Lost'
        ELSE 'Regular'
    END AS segment,
    -- Aggregates (Calculated PER group defined above)
    COUNT(*) AS customer_count,
    ROUND(AVG(monetary), 2) AS avg_monetary,
    ROUND(AVG(frequency), 2) AS avg_frequency
FROM rfm_scores
-- FIXED: Only group by the non-aggregated columns
GROUP BY r_score, f_score, m_score, segment
ORDER BY customer_count DESC;

-- ==========================================================
-- MODEL 2: DELIVERY PERFORMANCE VS. REVIEW SCORES
-- ==========================================================
-- Goal: Quantify the impact of delivery delays on customer satisfaction.

SELECT 
    -- Bucket the delay into categories
    CASE 
        WHEN EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400 <= -5 THEN 'Very Early (>5 days)'
        WHEN EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400 <= 0 THEN 'On Time / Early'
        WHEN EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400 <= 3 THEN 'Slightly Late (1-3 days)'
        ELSE 'Very Late (>3 days)'
    END AS delivery_performance_bucket,
    COUNT(*) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    -- Calculate % of 5-star reviews in each bucket
    ROUND(100.0 * SUM(CASE WHEN r.review_score = 5 THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_5_star_reviews
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_performance_bucket
ORDER BY delivery_performance_bucket;

-- ==========================================================
-- MODEL 3: SELLER PERFORMANCE RANKING (Window Functions)
-- ==========================================================
-- Goal: Identify top and bottom performing sellers by revenue and rating.

SELECT 
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    ROUND(AVG(r.review_score), 2) AS avg_seller_rating,
    -- Rank sellers by Revenue within their State
    RANK() OVER (PARTITION BY s.seller_state ORDER BY SUM(oi.price) DESC) AS state_revenue_rank,
    -- Rank sellers by Rating Globally
    RANK() OVER (ORDER BY AVG(r.review_score) DESC) AS global_rating_rank
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id, s.seller_state
HAVING COUNT(DISTINCT oi.order_id) > 10 -- Filter out sellers with very few orders
ORDER BY total_revenue DESC
LIMIT 20;