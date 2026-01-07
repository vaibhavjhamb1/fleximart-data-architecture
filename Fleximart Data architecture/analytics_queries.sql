-- QUESTION 1
SELECT 
    d.year, 
    d.quarter, 
    d.month_name, 
    SUM(f.total_amount) AS total_sales, 
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year, d.quarter, d.month, d.month_name
ORDER BY d.year, d.month ASC;

-- QUESTION 2
SELECT 
    p.product_name,
    p.category,
    SUM(f.quantity_sold) AS total_units_sold,
    SUM(f.total_amount) AS product_revenue,
    -- Calculate percentage: (Product Revenue / Grand Total Revenue) * 100
    ROUND((SUM(f.total_amount) / (SELECT SUM(total_amount) FROM fact_sales)) * 100, 2) AS revenue_contribution_pct
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name, p.category
ORDER BY product_revenue DESC
LIMIT 10;

-- QUESTION 3
WITH CustomerSpending AS (
    SELECT 
        customer_key,
        SUM(total_amount) AS total_spent
    FROM fact_sales
    GROUP BY customer_key
)
SELECT 
    CASE 
        WHEN total_spent > 50000 THEN 'High Value'
        WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment,
    COUNT(customer_key) AS customer_count,
    SUM(total_spent) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS avg_revenue_per_customer
FROM CustomerSpending
GROUP BY segment
ORDER BY total_revenue DESC;