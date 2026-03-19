# Data Dictionary: Olist E-Commerce Dataset

## Overview
This document defines the schema, data types, and business logic for the Olist Brazilian E-Commerce dataset loaded into PostgreSQL.

## Tables

### 1. customers
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `customer_id` | TEXT | Unique identifier for the customer order | PK |
| `customer_unique_id` | TEXT | Unique identifier for the customer across orders | |
| `customer_zip_code_prefix` | INT | First 5 digits of customer zip code | |
| `customer_city` | TEXT | Customer city | |
| `customer_state` | TEXT | Customer state (2-letter abbreviation) | |

### 2. orders
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `order_id` | TEXT | Unique identifier for the order | PK |
| `customer_id` | TEXT | Reference to customer table | FK |
| `order_status` | TEXT | Status of the order (e.g., delivered, shipped, canceled) | |
| `order_purchase_timestamp` | TIMESTAMP | Date and time of purchase | |
| `order_delivered_customer_date` | TIMESTAMP | Actual delivery date to customer | |
| `order_estimated_delivery_date` | TIMESTAMP | Expected delivery date | |

### 3. order_items
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `order_id` | TEXT | Reference to order table | PK, FK |
| `order_item_id` | INT | Sequential item number within the order | PK |
| `product_id` | TEXT | Reference to product table | FK |
| `seller_id` | TEXT | Reference to seller table | FK |
| `price` | NUMERIC | Item price in BRL | |
| `freight_value` | NUMERIC | Shipping cost in BRL | |

### 4. order_payments
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `order_id` | TEXT | Reference to order table | PK, FK |
| `payment_sequential` | INT | Sequence of payment method used | PK |
| `payment_type` | TEXT | Method (e.g., credit_card, boleto) | |
| `payment_value` | NUMERIC | Total amount paid | |

### 5. order_reviews
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `review_id` | TEXT | Unique identifier for the review | PK |
| `order_id` | TEXT | Reference to order table | FK |
| `review_score` | INT | Rating from 1 to 5 | |
| `review_creation_date` | TIMESTAMP | Date review was submitted | |

### 6. products
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `product_id` | TEXT | Unique identifier for the product | PK |
| `product_category_name` | TEXT | Original category name (Portuguese) | FK |
| `product_weight_g` | INT | Product weight in grams | |

### 7. sellers
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `seller_id` | TEXT | Unique identifier for the seller | PK |
| `seller_state` | TEXT | Seller state abbreviation | |

### 8. product_category_name_translation
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `product_category_name` | TEXT | Original category name | PK |
| `product_category_name_english` | TEXT | Translated category name | |

### 9. geolocation
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| `geolocation_zip_code_prefix` | INT | Zip code prefix | |
| `geolocation_lat` | NUMERIC | Latitude coordinate | |
| `geolocation_lng` | NUMERIC | Longitude coordinate | |

## Data Loading Notes
- All CSV files were loaded using PostgreSQL `COPY` command.
- Timestamps converted to `TIMESTAMP` type during ingestion.
- Null values handled according to original dataset specifications.