-- 02_eda_queries.sql
-- Purpose: Exploratory Data Analysis to identify trends, seasonality, and initial segments.
-- Author: Sarra Hammouda
-- Date: March 2026

-- ==========================================================
-- RULE: Apply Cleaning Filters from Phase 3
-- We will consistently filter for: 
-- 1. status = 'delivered'
-- 2. non-null customer_ids
-- 3. valid dates
-- ==========================================================

-- 1. TIME SERIES: Monthly Revenue Trend (2016-2018)
-- Are there seasonal spikes? (e.g., Black Friday, Holidays)
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    AVG(oi.price) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.customer_id IS NOT NULL
  AND o.order_delivered_customer_date >= o.order_purchase_timestamp
GROUP BY 1
ORDER BY 1;

-- 2. GEOGRAPHIC: Revenue by State (Customer Location)
-- Which regions are most valuable?
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.customer_id IS NOT NULL
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. PRODUCT: Top 10 Categories by Revenue
-- What are people actually buying?
SELECT 
    pcnt.product_category_name_english,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_item_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt ON p.product_category_name = pcnt.product_category_name
WHERE o.order_status = 'delivered'
  AND pcnt.product_category_name_english IS NOT NULL
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. PAYMENT: Payment Method Distribution & Value
-- Do credit card users spend more than boleto users?
SELECT 
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS usage_count,
    SUM(op.payment_value) AS total_value,
    ROUND(AVG(op.payment_value), 2) AS avg_transaction_value
FROM order_payments op
JOIN orders o ON op.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY total_value DESC;

-- 5. LOGISTICS: Delivery Performance (Actual vs Estimated)
-- How many days late are deliveries on average?
SELECT 
    ROUND(AVG(EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400), 2) AS avg_delay_days,
    COUNT(*) AS total_delivered_orders,
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS late_deliveries
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

-- 6. CUSTOMER BEHAVIOR: Repeat Purchase Rate (Basic)
-- How many unique customers have bought more than once?
WITH customer_orders AS (
    SELECT customer_id, COUNT(order_id) as order_count
    FROM orders
    WHERE order_status = 'delivered' AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT 
    COUNT(*) AS total_unique_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END)::numeric / COUNT(*)::numeric * 100, 2) AS repeat_rate_pct
FROM customer_orders;