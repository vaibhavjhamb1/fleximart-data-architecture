CREATE DATABASE IF NOT EXISTS fleximart_dw;
USE fleximart_dw;

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_of_week VARCHAR(15),
    month INT,
    month_name VARCHAR(15),
    quarter VARCHAR(2),
    year INT,
    is_weekend BOOLEAN
);

CREATE TABLE dim_product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    unit_cost DECIMAL(10,2),
    price DECIMAL(10,2)
);

CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE fact_sales (
    sales_key INT PRIMARY KEY AUTO_INCREMENT,
    date_key INT,
    product_key INT,
    customer_key INT,
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);