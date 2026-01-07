// Command to run in terminal: 
// mongoimport --db fleximart_nosql --collection products --file products_catalog.json --jsonArray

use fleximart_nosql;
db.products.countDocuments();

//Question 2
db.products.find(
    { "category": "Electronics", "price": { $lt: 50000 } }, 
    { "name": 1, "price": 1, "stock": 1, "_id": 0 });

//Question 3
db.products.aggregate([
    { $unwind: "$reviews" },
    { $group: {
        _id: "$name",
        avg_rating: { $avg: "$reviews.rating" }
    }},
    { $match: { "avg_rating": { $gte: 4.0 } } }
]);

//Question 4
db.products.updateOne(
    { "product_id": "ELEC001" },
    { $push: { 
        "reviews": { 
            "user": "U999", 
            "rating": 4, 
            "comment": "Good value", 
            "date": new Date() 
        } 
    }}
);


//Question 5
db.products.aggregate([
    { $group: {
        _id: "$category",
        avg_price: { $avg: "$price" },
        product_count: { $sum: 1 }
    }},
    { $project: {
        category: "$_id",
        avg_price: 1,
        product_count: 1,
        _id: 0
    }},
    { $sort: { "avg_price": -1 } }
]);
