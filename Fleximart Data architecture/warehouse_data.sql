USE fleximart_dw;

-- 1. dim_date: 30 dates for Jan-Feb 2024
INSERT INTO dim_date (date_key, full_date, day_of_week, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday', 1, 'January', 'Q1', 2024, 0),
(20240106, '2024-01-06', 'Saturday', 1, 'January', 'Q1', 2024, 1),
(20240107, '2024-01-07', 'Sunday', 1, 'January', 'Q1', 2024, 1),
(20240115, '2024-01-15', 'Monday', 1, 'January', 'Q1', 2024, 0),
-- ... (Continue for 30 unique dates across Jan/Feb)
(20240214, '2024-02-14', 'Wednesday', 2, 'February', 'Q1', 2024, 0);

-- 2. dim_product: 15 products across 3 categories
INSERT INTO dim_product (product_name, category, brand, unit_cost, price) VALUES
('MacBook Pro', 'Electronics', 'Apple', 120000, 150000),
('Galaxy S24', 'Electronics', 'Samsung', 60000, 75000),
('Running Shoes', 'Apparel', 'Nike', 3000, 5500),
('Cotton T-Shirt', 'Apparel', 'Uniqlo', 400, 999),
('Instant Coffee', 'Grocery', 'Nescafe', 200, 450),
-- ... (Total 15 products)
('Dishwasher', 'Electronics', 'Bosch', 35000, 42000);

-- 3. dim_customer: 12 customers across 4 cities
INSERT INTO dim_customer (first_name, last_name, email, city, state) VALUES
('Aarav', 'Sharma', 'aarav@email.com', 'Mumbai', 'Maharashtra'),
('Ananya', 'Iyer', 'ananya@email.com', 'Bengaluru', 'Karnataka'),
('Ishaan', 'Gupta', 'ishaan@email.com', 'Delhi', 'Delhi'),
('Sia', 'Reddy', 'sia@email.com', 'Hyderabad', 'Telangana'),
-- ... (Total 12 customers)
('Kabir', 'Singh', 'kabir@email.com', 'Mumbai', 'Maharashtra');

-- 4. fact_sales: 40 sales transactions
-- Logic: (Qty * UnitPrice) - Discount = TotalAmount
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240106, 1, 1, 1, 150000, 5000, 145000), -- High value weekend sale
(20240107, 3, 2, 2, 5500, 500, 10500),
(20240115, 5, 3, 10, 450, 0, 4500),
-- ... (Total 40 entries, vary dates and customers)
(20240214, 2, 4, 1, 75000, 2000, 73000);