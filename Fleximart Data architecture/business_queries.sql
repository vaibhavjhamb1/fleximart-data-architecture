-- Generate a detailed report showing each customer's name, email, total number of orders placed, and total amount spent. Include only customers who have placed at least 2 orders and spent more than ₹5,000. Order by total amount spent in descending order.
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(s.sales_key) AS total_orders,
    SUM(s.quantity * p.price) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id 
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(s.sales_key) >= 2 AND SUM(s.quantity * p.price) > 5000
ORDER BY total_spent DESC;

-- For each product category, show the category name, number of different products sold, total quantity sold, and total revenue generated. Only include categories that have generated more than ₹10,000 in revenue. Order by total revenue descending
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS num_products,
    SUM(s.quantity) AS total_quantity_sold,
    -- Calculate revenue by multiplying sales quantity by product price
    SUM(s.quantity * p.price) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
-- Filter for categories generating more than ₹10,000
HAVING SUM(s.quantity * p.price) > 10000
ORDER BY total_revenue DESC;

-- Show monthly sales trends for the year 2024. For each month, display the month name, total number of orders, total revenue, and the running total of revenue (cumulative revenue from January to that month).
SELECT 
    MONTHNAME(s.transaction_date) AS month_name,
    COUNT(s.sales_key) AS total_orders,
    SUM(s.quantity * p.price) AS total_revenue,
    -- Window Function to calculate Cumulative Revenue
    SUM(SUM(s.quantity * p.price)) OVER (ORDER BY MONTH(s.transaction_date)) AS running_total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE YEAR(s.transaction_date) = 2024
GROUP BY MONTH(s.transaction_date), month_name
ORDER BY MONTH(s.transaction_date);
