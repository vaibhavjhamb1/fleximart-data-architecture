FlexiMart Database Schema Documentation

1. Entity-Relationship Description
ENTITY: customers
Purpose: Stores unique customer profile information.

Attributes:
customer_key: Unique surrogate identifier (Primary Key).
first_name: Customer's first name.
last_name: Customer's last name.
email: Validated electronic mail address.
phone: Standardized phone number in +91-XXXXXXXXXX format.
Relationships: One customer can place MANY orders (1:M relationship with the sales table).

ENTITY: products
Purpose: Stores information about the products available for sale.

Attributes:
product_key: Unique surrogate identifier (Primary Key).
product_name: The name of the product.
category: Standardized category name (Title Case).
price: Unit price of the product.
Relationships: One product can be sold MANY times (1:M relationship with the sales table).

ENTITY: sales
Purpose: Records individual transaction details.

Attributes:
sales_key: Unique transaction identifier (Primary Key).
customer_id: Reference to the customer who made the purchase (Foreign Key).
product_id: Reference to the product purchased (Foreign Key).
transaction_date: Standardized date of sale in YYYY-MM-DD format.
quantity: Number of items purchased.

2. Normalization Explanation
The FlexiMart database design adheres to the Third Normal Form (3NF) for the following reasons:
1NF (First Normal Form): Every column contains atomic values, and there are no repeating groups. The use of surrogate keys ensures each record is unique.
2NF (Second Normal Form): The schema is in 1NF and all non-key attributes are fully functionally dependent on the primary key. For example, product_name is entirely dependent on the product_key.
3NF (Third Normal Form): There are no transitive dependencies; non-key attributes depend only on the primary key.
Anomaly Avoidance: This design avoids update, insert, and delete anomalies. For instance, if a product is deleted, the customer’s information remains intact because it is stored in a separate table.

3. Representation
<img width="850" height="154" alt="image" src="https://github.com/user-attachments/assets/863b85ae-1ad7-4364-a9da-bf462805e150" />
<img width="648" height="99" alt="image" src="https://github.com/user-attachments/assets/a2663f93-74fd-4743-b159-eb9b43a61de9" />



