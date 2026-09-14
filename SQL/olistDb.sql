-- customers Table
select count(*) AS total_rows From customers;
Select count(*) AS total_col FROM information_schema.columns WHERE table_name='customers';
SELECT * FROM customers; -- customer_id is primary key

-- Top 10 state by customer count
SELECT customer_state, COUNT(customer_state) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC
LIMIT 10;

--Top 10 cities by customer count
SELECT customer_city,COUNT(customer_city) AS customer_count_city
FROM customers
GROUP BY customer_city
ORDER BY 2 DESC
LIMIT 10;

-- Total unique states
SELECT COUNT (DISTINCT customer_state) AS unique_state FROM customers;
-- Total unique cities
SELECT COUNT (DISTINCT customer_city) AS unique_city FROM customers;


-- Orders Table
SELECT * FROM orders;
-- Total rows
SELECT COUNT(*) AS total_rows FROM order_reviews;
--Total columns
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='orders';
-- PK
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_id,
    COUNT(order_id) AS non_null_order_id
FROM orders;
SELECT * FROM orders;
--order_id column me NULL values
SELECT COUNT(*) AS total_null
FROM orders
WHERE order_id  is NULL;






-- geolocation
SELECT COUNT(*) AS total_rows FROM geolocation;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='geolocation';
SELECT * FROM geolocation; -- 

-- order_items
SELECT COUNT(*) AS total_rows FROM order_items;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='order_items';
SELECT * FROM order_items;
-- order_payments
SELECT COUNT(*) AS total_rows FROM order_payments;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='order_payments';

-- order_reviews
SELECT COUNT(*) AS total_rows FROM order_reviews;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='order_reviews';



--product_category_name 
SELECT COUNT(*) AS total_rows FROM product_category_name;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='product_category_name';

-- products
SELECT COUNT(*) AS total_rows FROM products;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='products';

-- sellers
SELECT COUNT(*) AS total_rows FROM sellers;
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='sellers';

-- customers

SELECT 
    column_name, 
    data_type, 
    character_maximum_length AS max_length
FROM information_schema.columns
WHERE table_schema = 'public' 
  AND table_name = 'customers'
ORDER BY ordinal_position;

SELECT count(*) FROM customers 
WHERE customer_id is NULL;
SELECT * FROM ORDERS;

-- DUPLICATE
SELECT order_id,COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*)>1;

-- TOTAL UNIQUE ORDER STATUS
SELECT COUNT(DISTINCT  order_status)
FROM orders;

--Har order_status me kitne orders hain?
SELECT order_status,COUNT(order_status) AS order_count
FROM orders
GROUP BY order_status;

--Ab Orders table ka earliest order date find karo.
SELECT MIN(order_purchase_timestamp) AS earliest_order_place_date
FROM orders;

--Sabse latest order kis date ko place hua tha?
SELECT MAX(order_purchase_timestamp) AS latest_order_place_date
FROM orders;

--order status count
SELECT order_status,COUNT(order_status) AS order_status_count
FROM orders
GROUP BY order_status
ORDER BY order_status_count DESC;

select count(*) FROM orders;
-- Cancellation/Unavailable Rate (%)
SELECT ROUND(COUNT(*) FILTER ( WHERE order_status IN('canceled','unavailable'))*100.0/
	COUNT(order_status),2) AS cancellation_unavailable_rate
FROM orders;



-- Year-wise total orders.
SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,COUNT(order_id) as total_order_year
FROM orders
GROUP BY EXTRACT(YEAR FROM order_purchase_timestamp);

-- Month-wise total orders.
SELECT EXTRACT(MONTH FROM order_purchase_timestamp) AS order_month, COUNT(order_id) AS total_order_month
FROM orders
GROUP BY EXTRACT(MONTH FROM order_purchase_timestamp);
-- Kis year me sabse zyada orders aaye?
SELECT EXTRACT(YEAR FROM order_purchase_timestamp),COUNT(order_id) AS total_order_year
FROM orders
GROUP BY EXTRACT(YEAR FROM order_purchase_timestamp)
ORDER BY total_order_year DESC;
-- Kis month me sabse zyada orders aaye?
SELECT EXTRACT(MONTH FROM order_purchase_timestamp) AS order_month, COUNT(order_id) AS total_order_month
FROM orders
GROUP BY EXTRACT(MONTH FROM order_purchase_timestamp)
ORDER BY total_order_month DESC;

--  -----------                E. Delivery Analysis
-- Estimated delivery date aur actual customer delivery date ka difference analyze karo.
SELECT order_id,order_estimated_delivery_date, order_delivered_customer_date,(order_estimated_delivery_date-order_delivered_customer_date) AS est_actu_dele_diff
FROM orders;

-- Kitne orders estimated date se pehle deliver hue?
SELECT COUNT(*)
FROM orders
WHERE order_estimated_delivery_date>order_delivered_customer_date;

-- Kitne orders estimated date ke baad deliver hue?
SELECT COUNT(*)
FROM orders
WHERE order_estimated_delivery_date<order_delivered_customer_date;
-- Average delivery time find karo.
SELECT 
	AVG(order_estimated_delivery_date-order_delivered_customer_date) AS avg_del_time
FROM orders;

-----------------------------------🔴 F. Business Insights---------------------------------------------------------------------------

-- Analysis ke baad kam se kam 4–5 insights likho:


-- Order fulfillment kaisa hai? 
-- 97%+ orders successfully delivered, indicating very strong overall fulfillment performance.
 
-- Cancellation/unavailability rate kya indicate karta hai? =1.24%(Very less)
-- Only 1.24% of orders were canceled or unavailable, indicating a very low failure/unfulfillment rate.

-- Orders ka growth trend kaisa hai?:: orders increasing every year
--Orders increased year over year, indicating growing customer demand and business expansion.

-- Peak ordering period/year kaunsa hai?:: 2018( 54011 orders )
-- 2018 recorded the highest order volume with 54,011 orders, making it the strongest year in terms of customer demand.

-- Delivery performance kaisi hai?:: 88% del on time 
--88% of orders were delivered on time, indicating good delivery performance, although there is still room to improve the remaining late deliveries.

-------------------------------------⭐ Overall conclusion

--Olist shows strong order fulfillment and consistent growth, with a very low cancellation/unavailability rate. 
--However, improving the 12% late-delivery portion could further enhance customer experience.




----------------------------------------order_items---------------------------------------------------------
-- 🟢 A. Basic Understanding

-- Total rows find karo.
SELECT COUNT(*) AS total_rows FROM order_items;
-- Total columns find karo.
SELECT COUNT(*) AS total_col FROM information_schema.columns WHERE table_name='order_items';
-- Primary key identify karo.
SELECT
	COLUMN_NAME,
	CONSTRAINT_NAME
FROM 
	INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
	TABLE_NAME='order_items';


-- Possible foreign keys / join columns identify karo.
-- product_id might be possible join column


--order_id me NULL values check karo
SELECT COUNT(*) AS total_null_order_id
FROM order_items
WHERE order_id IS NULL;

--order_item_id me NULL values hain ya nahi.
SELECT COUNT(*) AS total_null_order_item_id
FROM order_items
WHERE order_item_id IS NULL;

--product_id me NULL values hain ya nahi.
SELECT COUNT(*) AS total_null_product_id
FROM order_items
WHERE product_id IS NULL;

--seller_id me NULL values hain ya nahi.
SELECT COUNT(*) AS total_null_seller_id
FROM order_items
WHERE seller_id IS NULL;

--Ab order_id + order_item_id ka duplicate combination check karo.
SELECT order_id,order_item_id,COUNT(order_item_id)
FROM order_items
GROUP BY order_id,order_item_id
HAVING COUNT(order_item_id)>1;

--order_items table me total unique orders find karo.
SELECT COUNT(DISTINCT order_id) AS total_unique_orders
FROM order_items;

--order_items table me total unique product_id kitne hain?
SELECT COUNT(DISTINCT product_id) AS total_unique_products
FROM order_items;

--order_items table me total unique seller_id kitne hain?
SELECT COUNT(DISTINCT seller_id) AS total_unique_seller
FROM order_items;

--order_items table me total number of items sold kitne hain?

SELECT COUNT(order_id) AS total_sold_items
FROM order_items;


--order_items table ke price column ka minimum product price find karo.
SELECT MIN(price) AS min_price
FROM order_items;

--Maximum price kya hai?
SELECT MAX(price) AS max_price
FROM order_items;

--Average product price kya hai?
SELECT AVG(price) AS avg_price
FROM order_items;


--Minimum freight_value kya hai?
SELECT MIN(freight_value) AS min_freight_value
FROM order_items;
--Maximum freight_value kya hai?
SELECT MAX(freight_value) AS max_freight_value
FROM order_items;
--Average freight_value kya hai?
SELECT AVG(freight_value) AS AVG_freight_value
FROM order_items;

--Top 10 products by number of items sold find karo.
SELECT * FROM order_items;
SELECT product_id,count(product_id) AS total_sold_products
FROM order_items
GROUP BY product_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 products by total sales value.
SELECT product_id,SUM(price) AS total_sales_value
FROM order_items
GROUP BY product_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 products by average product price.
SELECT product_id,ROUND(AVG(price),2) AS avg_sales_value
FROM order_items
GROUP BY product_id
ORDER BY 2 DESC
LIMIT 10;

--Ab Top 10 sellers by number of items sold find karo.
SELECT seller_id,COUNT(product_id) AS total_items_sold
FROM order_items
GROUP BY seller_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 sellers by total sales value.
SELECT seller_id,SUM(price) AS total_sales
FROM order_items
GROUP BY seller_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 sellers by average freight value.
SELECT seller_id,ROUND(AVG(freight_value),2) AS avg_freight_value
FROM order_items
GROUP BY seller_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 products by total freight value.
SELECT product_id,SUM(freight_value) AS total_freight_value
FROM order_items
GROUP BY product_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 sellers by total freight value.
SELECT seller_id,SUM(freight_value) AS total_freight_value_seller
FROM order_items
GROUP BY seller_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 products by total number of orders.
SELECT product_id,COUNT(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY product_id
ORDER BY 2 DESC
LIMIT 10;

--Top 10 sellers by total number of unique orders.
SELECT seller_id,COUNT(DISTINCT order_id) AS total_orders_seller
FROM order_items
GROUP BY seller_id
ORDER BY 2 DESC
LIMIT 10;


------------------Ab order_items table ka Business Analysis karenge.-------------------------

-- Total Revenue (Sales Value)
SELECT SUM(price) AS total_revenue FROM order_items;
-- Average Order Item Price
SELECT ROUND(AVG(price),2) AS avg_order_price FROM order_items;
-- Total Freight Cost
SELECT SUM(freight_value) AS total_freight_value FROM order_items;
-- Average Freight Cost per Order Item
SELECT AVG(freight_value) AS avg_freight_value FROM order_items;


--------------order_items ko products table ke saath JOIN karke Product Category analysis karenge.-------------
SELECT * FROM products;
SELECT * FROM order_items;
-- Category-wise total sales
SELECT p.product_category_name,SUM(oi.price) AS total_sales_category
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC;
-- Category-wise items sold
SELECT p.product_category_name,COUNT(oi.order_id) AS total_items_sold_category
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC;
-- Category-wise average product price
SELECT p.product_category_name,ROUND(AVG(oi.price),2) AS avg_price_category
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC;

--Category-wise total freight cost
SELECT p.product_category_name,SUM(oi.freight_value) AS total_freight_value_category
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC;

-- Top 10 product categories by number of unique products find karo.
SELECT p.product_category_name,COUNT(DISTINCT oi.product_id) AS total_unique_products_category
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC
LIMIT 10;

--Top 10 product categories by total number of unique orders find karo.
SELECT p.product_category_name,COUNT(DISTINCT oi.order_id) AS total_unique_orders_category
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC
LIMIT 10;

--Top 10 product categories by total freight cost per order item find karo.
SELECT p.product_category_name,SUM(freight_value) AS total_freight_value
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_category_name
ORDER BY 2 DESC
LIMIT 10;

--Top 10 product categories by total sales value aur total freight cost dono compare karo.
SELECT product_category_name,SUM(oi.price) AS total_sales_value, SUM(oi.freight_value) AS total_frieght_value
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY product_category_name
ORDER BY 2 DESC
LIMIT 10;


-- Ab hum order_items + orders ko JOIN karke ek important analysis karenge:
select * from orders;
select * from order_items;
-- Order status-wise total sales value find karo.
SELECT o.order_status,SUM(oi.price) AS total_sales_by_orderstatus
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_status
ORDER BY 2 DESC;

-- Order status-wise total number of orders find karo.
SELECT order_status,COUNT(order_id) AS total_orders_by_orderstatus
FROM orders
GRoUP BY order_status
ORDER BY 2 DESC;


-- Order status-wise total sales value find karo.
SELECT o.order_status,SUM(oi.price) AS total_sales_by_orderstatus
FROM order_items oi
JOIN orders o
ON o.order_id=oi.order_id
GROUP BY order_status
ORDER BY 2 DESC;

--Order status-wise total number of orders find karo.
SELECT order_status,COUNT(order_id) AS total_orders_by_orderstatus
FROM orders
GRoUP BY order_status
ORDER BY 2 DESC;

-- 44. Order status-wise average order-item price find karo.
SELECT o.order_status,ROUND(AVG(oi.price),2) AS avg_price_by_orderstatus
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_status
ORDER BY 2 DESC;
-- 45. Order status-wise total freight cost find karo.
SELECT o.order_status,SUM(oi.freight_value) AS total_freight_by_orderstatus
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_status
ORDER BY 2 DESC;

-- 46. Order status-wise average freight cost find karo.
SELECT o.order_status,ROUND(AVG(oi.freight_value),2) AS avg_freight_by_orderstatus
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_status
ORDER BY 2 DESC;

-- 47. Order status-wise total items sold find karo.
SELECT o.order_status,COUNT(o.order_id) AS total_item_sold_by_orderstatus
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_status
ORDER BY 2 DESC;

select * from orders;
select * from order_items;
select * from customers;
-- 48 Customer state-wise total orders find karo.
SELECT c.customer_state,COUNT(o.order_id) AS total_orders_by_state
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY customer_state
ORDER BY 2 DESC; 
-- 49 Top 10 customer states by total sales value find karo.
SELECT c.customer_state,SUM(oi.price) AS total_sales_by_state
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN order_items oi
ON oi.order_id=o.order_id
GROUP BY c.customer_state
ORDER BY 2 DESC
LIMIT 10;


-- 50 Top 10 customer cities by total sales value find karo.
SELECT c.customer_city,SUM(oi.price) AS total_sales_by_city
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_city
ORDER BY 2 DESC
LIMIT 10;

-- 51 Order status-wise category sales find karo.
SELECT o.order_status,p.product_category_name,SUM(oi.price) AS total_sales_by_category
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON p.product_id=oi.product_id
GROUP BY order_status,product_category_name
ORDER BY 3 DESC;
-- 52 Top 10 categories by delivered-order sales value find karo.
SELECT p.product_category_name, SUM(oi.price) AS total_sales_by_category_delivered_status 
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN orders o
ON o.order_id=oi.order_id
WHERE o.order_status='delivered'
GROUP BY p.product_category_name
ORDER BY 2 DESC
LIMIT 10;
-- 53 Top 10 categories by canceled/unavailable-order sales value find karo.
SELECT p.product_category_name,SUM(oi.price) AS total_sales_by_category_canceled_unavailable_status
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN orders o
ON o.order_id=oi.order_id
WHERE (o.order_status='canceled') OR (o.order_status='unavailable') 
GROUP BY product_category_name
ORDER BY 2 DESC 
LIMIT 10;



-- #54. Average actual delivery time find karo.
SELECT 
	AVG(order_delivered_customer_date-order_purchase_timestamp) AS avg_del_time
FROM orders;

-- #55. Year-wise average delivery time find karo.
SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,AVG(order_delivered_customer_date-order_purchase_timestamp) AS avg_delivery_by_year
FROM orders 
GROUP BY order_year
ORDER BY 2 DESC;
-- #56. Year-wise on-time delivery percentage find karo.
SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_customer_date <= order_estimated_delivery_date
        ) / COUNT(*),
        2
    ) AS ontime_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY order_year
ORDER BY 2 DESC;
-- #57. Year-wise late delivery percentage find karo.
SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
ROUND(
	100.0*COUNT(*) FILTER(
		WHERE order_delivered_customer_date > order_estimated_delivery_date
	)/COUNT(*),2) AS late_delivery_by_year
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL 
 GROUP BY order_year
 ORDER BY 2 DESC;

-- #58. Month-wise on-time delivery percentage find karo.
SELECT EXTRACT(MONTH FROM order_purchase_timestamp) AS order_month,
ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_customer_date <= order_estimated_delivery_date
        ) / COUNT(*),
        2
    ) AS ontime_delivery_percentage_by_month
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY order_month
ORDER BY 2 DESC;

-- 📊 Business Analysis
-- #59. Total orders me delivered, shipped, canceled aur unavailable ka percentage contribution find karo.
SELECT order_status, COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),2) AS percentage_contribution
FROM orders
WHERE order_status IN ('delivered', 'shipped', 'canceled', 'unavailable')
GROUP BY order_status
ORDER BY percentage_contribution DESC;
-- #60. Delivered orders ka average sales value find karo.
SELECT ROUND(AVG(oi.price),2)AS avg_sales_value_delivered_orders
FROM order_items oi
JOIN orders o
on oi.order_id=o.order_id
WHERE o.order_status='delivered';

-- #61. Canceled + unavailable orders ki total sales value find karo.
SELECT SUM(oi.price)AS total_sales_value_cancelled_unavailable_orders
FROM order_items oi
JOIN orders o
on oi.order_id=o.order_id
WHERE (o.order_status='canceled') OR (o.order_status='unavailable');
-- #62. Delivered vs canceled/unavailable orders ka sales comparison karo.
SELECT o.order_status,SUM(oi.price) AS sales_comparision
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
WHERE order_status IN('delivered','canceled','unavailable')
GROUP BY order_status
ORDER BY sales_comparision DESC;

-- 🔥 Final Combined Analysis

-- #66. Year-wise total orders + total sales + total freight cost ek hi query me nikalo.
SELECT
EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.price) AS total_sales,
SUM(oi.freight_value) AS total_freight_cost
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_year
ORDER BY 2 DESC;


-- #67. Customer state-wise total orders + total sales ek hi query me nikalo.
SELECT 
c.customer_state,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.price) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN order_items oi
ON oi.order_id=o.order_id
GROUP BY customer_state
ORDER BY 3 DESC;


select * from orders;
select * from order_items;
select * from products;
select * from customers;
-- #68. Product category-wise total orders + total sales + total freight ek hi query me nikalo.
SELECT 
p.product_category_name,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.price) AS total_sales,
SUM(oi.freight_value) AS total_freight_value
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN orders o
ON o.order_id=oi.order_id
GROUP BY product_category_name
ORDER BY 2 DESC;
-- #69. Top 10 customer states by sales find karo, aur unka total orders + total sales show karo.
SELECT 
c.customer_state,
SUM(oi.price) AS total_sales,
COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN order_items oi
ON oi.order_id=o.order_id
GROUP BY customer_state
ORDER BY 2 DESC
LIMIT 10;
-- #70. Top 10 product categories by sales find karo, aur total orders + total sales + total freight ek saath show karo.
SELECT 
p.product_category_name,
SUM(oi.price) AS total_sales,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.freight_value) AS total_freight_value
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN orders o
ON o.order_id=oi.order_id
GROUP BY product_category_name
ORDER BY 2 DESC
LIMIT 10;