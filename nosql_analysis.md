Section A: Limitations of RDBMS

While the current relational database is excellent for structured sales data, it struggles with the high variety of modern e-commerce product catalogs.

Attribute Diversity: In an RDBMS, products like laptops (RAM, CPU) and shoes (size, color) require either many NULL columns or a complex "Entity-Attribute-Value" (EAV) model, which degrades performance.

Schema Rigidity: Adding a new product type, such as "Smart Home Devices," requires an ALTER TABLE command. For large datasets, this can lock the table and cause significant system downtime.

Nested Data: Storing customer reviews in an RDBMS requires a separate reviews table and expensive JOIN operations. This makes it difficult to retrieve a product and all its associated reviews in a single, fast operation.

Section B: NoSQL Benefits 

MongoDB provides a document-oriented approach that directly addresses the limitations of the relational model.

Flexible Schema: MongoDB uses JSON-like documents (BSON), allowing each product to have its own unique set of fields without affecting other records. Laptops and shoes can coexist in the same collection with different attributes.

Embedded Documents: Instead of a separate table, customer reviews can be stored as an "array of objects" directly within the product document. This allows the application to fetch a product and its reviews in one single read.

Horizontal Scalability: MongoDB is designed to scale out across multiple servers (sharding), making it easier to handle massive spikes in web traffic compared to the "scale-up" (vertical) approach of RDBMS.

Section C: Trade-offs 

The transition to NoSQL involves certain trade-offs. MongoDB traditionally sacrifices strict ACID compliance (Atomicity, Consistency, Isolation, Durability) in favor of performance and availability. While relational databases ensure that data is perfectly consistent across all tables at all times, NoSQL often relies on Eventual Consistency. Furthermore, since data is often duplicated (denormalized) within documents to avoid joins, the storage requirements can be higher than a normalized MySQL database.
