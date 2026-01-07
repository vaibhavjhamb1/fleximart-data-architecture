1.Schema Overview 
DIMENSION TABLE: dim_product
Purpose: Stores descriptive attributes for all items in the FlexiMart catalog.

Type: Conformed dimension.

Attributes:

product_key (PK): Surrogate key (integer).

product_name: Official name of the product.

category: Broad classification (e.g., Electronics, Apparel).

brand: The manufacturer or brand name.

supplier_name: Name of the primary vendor.

unit_cost: Original cost to the business for procurement.

reorder_level: Minimum stock threshold before replenishment is needed.

DIMENSION TABLE: dim_customer
Purpose: Stores unique profile and demographic data for registered customers.

Type: Conformed dimension.

Attributes:

customer_key (PK): Surrogate key (integer).

first_name: Customer's given name.

last_name: Customer's family name.

email: Validated electronic mail address.

phone: Standardized phone number (+91-XXXXXXXXXX).

city: Physical city of residence.

state: State or region.

loyalty_tier: Classification based on spending (e.g., Gold, Silver, Bronze).

Normalization Explanation 
3NF Status and Anomaly Avoidance: 

This Star Schema design adheres to the principles of Third Normal Form (3NF) within each table to ensure data integrity. In the dimension tables, every non-key attribute is fully functionally dependent on the primary key (surrogate key). For example, in dim_product, the category and unit_cost depend strictly on the product_key. There are no transitive dependencies; attributes like month_name in dim_date depend only on the date_key, meeting 3NF requirements.

By separating entities into distinct dimensions linked to a central fact_sales table via foreign keys, the design effectively avoids update, insert, and delete anomalies. An update anomaly is prevented because a change to a product's category only needs to be modified in one row in dim_product, and it automatically reflects across all related sales. Insert anomalies are avoided because new customers can be added to dim_customer before they make any purchases. Finally, delete anomalies are resolved because deleting a transaction from the fact table does not result in the loss of the underlying customer or product master data. This structure balances analytical performance with the rigorous data quality standards required for the FlexiMart business model.


2. Design Decisions
For the FlexiMart data warehouse, the schema was designed with specific structural choices to optimize analytical performance and data integrity.

Granularity: I chose a transaction line-item level grain for the fact_sales table. This ensures the highest level of detail, allowing the business to analyze not just total orders, but individual product performance, discounts per item, and specific quantity movements.

Surrogate Keys: The design utilizes surrogate keys (like customer_key) rather than natural keys (like email). This decouples the data warehouse from operational system changes, handles "Slowly Changing Dimensions" more efficiently, and improves join performance by using integers instead of long strings.

Drill-down and Roll-up: The star schema naturally supports hierarchical analysis. Users can roll-up from daily sales to monthly or quarterly trends using dim_date, or drill-down from broad product categories to specific SKU performance using dim_product.

When Order #101 is processed through your ETL pipeline, it is decomposed into a central fact and descriptive dimensions to support analytical reporting.

3. Sample Data Flow

I. The Source Transaction 
In the operational database, the data is often stored as a single flat record or a simple join:

Order ID: 101

Date: January 15, 2024

Customer: John Doe (Mumbai)

Product: Laptop (Electronics)

Quantity: 2

Price: ₹50,000

II. The Data Warehouse Transformation
The ETL process maps these attributes into the Star Schema components:

Central Fact Table: fact_sales
This table stores the numeric measures and links to dimensions via surrogate keys. | date_key | product_key | customer_key | quantity_sold | unit_price | total_amount | | :--- | :--- | :--- | :--- | :--- | :--- | | 20240115 | 5 | 12 | 2 | 50000 | 100000 |

Dimension Tables (Contextual Data)
These tables store the descriptive attributes that allow for "slicing and dicing" the data.

dim_date

date_key: 20240115

full_date: 2024-01-15

month: 1

quarter: Q1

dim_product

product_key: 5

product_name: Laptop

category: Electronics

dim_customer

customer_key: 12

customer_name: John Doe

city: Mumbai

III. Why this Flow Matters 
Efficiency: The fact_sales table remains very narrow (mostly numbers), making it extremely fast to sum millions of rows of revenue.

Integrity: If "John Doe" changes his email, we only update one row in dim_customer. All historical sales in fact_sales remain correctly linked via customer_key: 12.

Normalization: This demonstrates 3NF compliance within the warehouse, as non-key attributes (like city) are dependent only on their respective surrogate keys.
