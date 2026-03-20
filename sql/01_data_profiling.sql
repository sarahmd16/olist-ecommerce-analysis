-- 01_data_profiling.sql
-- Purpose: Assess data quality, identify nulls, duplicates, and logical anomalies.
-- Author: Sarra Hammouda
-- Date: March 2026

-- ==========================================================
-- 1. NULL CHECKS: Identify missing critical keys
-- Expectation: Primary keys should be 0. Foreign keys should be minimal.
-- ==========================================================
SELECT 'customers' as table_name, count(*) as total_rows, 
       sum(case when customer_id is null then 1 else 0 end) as null_customer_id,
       sum(case when customer_unique_id is null then 1 else 0 end) as null_unique_id
FROM customers
UNION ALL
SELECT 'orders', count(*), 
       sum(case when order_id is null then 1 else 0 end),
       sum(case when customer_id is null then 1 else 0 end)
FROM orders
UNION ALL
SELECT 'order_items', count(*), 
       sum(case when order_id is null then 1 else 0 end),
       sum(case when product_id is null then 1 else 0 end)
FROM order_items;

-- ==========================================================
-- 2. DUPLICATE CHECKS: Ensure unique identifiers are actually unique
-- Expectation: Count should equal Count(Distinct). If not, we have duplicates.
-- ==========================================================
SELECT 'orders' as table_name, count(*) as total_count, count(distinct order_id) as unique_count
FROM orders
UNION ALL
SELECT 'customers', count(*), count(distinct customer_id)
FROM customers
UNION ALL
SELECT 'products', count(*), count(distinct product_id)
FROM products;

-- ==========================================================
-- 3. LOGICAL ANOMALIES: Time Travel & Negative Values
-- Check for orders delivered BEFORE they were purchased (Data Error)
-- ==========================================================
SELECT count(*) as impossible_delivery_dates
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Check for negative prices or freight values (Data Error)
SELECT count(*) as negative_financial_values
FROM order_items
WHERE price < 0 OR freight_value < 0;

-- ==========================================================
-- 4. STATUS DISTRIBUTION: Understand the lifecycle
-- Are there many 'cancelled' or 'unavailable' orders we need to exclude later?
-- ==========================================================
SELECT order_status, count(*) as count, 
       round(count(*) * 100.0 / sum(count(*)) over (), 2) as percentage
FROM orders
GROUP BY order_status
ORDER BY count DESC;

-- ==========================================================
-- 5. REVIEW SCORE DISTRIBUTION
-- Is the scoring skewed? (e.g., everyone gives 5 stars)
-- ==========================================================
SELECT review_score, count(*) as count
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;