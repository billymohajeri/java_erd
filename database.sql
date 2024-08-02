-- CREATE TABLES --

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA IF NOT EXISTS billyApp;

CREATE TABLE IF NOT EXISTS billyApp.user (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(255),
    birth_date DATE,
    email VARCHAR(70) NOT NULL UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS billyApp.order (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES billyApp.user(id),
    date_time TIMESTAMP NOT NULL,
    comments TEXT,
    status INTEGER NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS billyApp.product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    description TEXT,
    images TEXT[],
    color VARCHAR(50) NOT NULL,
    meta JSON,
    rating NUMERIC(2,1),
    stock INTEGER
);

CREATE TABLE IF NOT EXISTS billyApp.order_product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES billyApp.order(id),
    product_id UUID NOT NULL REFERENCES billyApp.product(id)
);

CREATE TABLE IF NOT EXISTS billyApp.cart (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL UNIQUE REFERENCES billyApp.user(id),
);

CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id),
    method VARCHAR(50) NOT NULL,
    amount NUMERIC(10,2) NOT NULL
);

CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id),
    review TEXT NOT NULL,
    rating NUMERIC(3,2) NOT NULL,
    image VARCHAR(255)
);

CREATE TABLE wishlists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    product_id UUID NOT NULL REFERENCES products(id),
    name VARCHAR(50)
);

CREATE TABLE wishlist_product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    wishlist_id UUID NOT NULL REFERENCES wishlists(id),
    product_id UUID NOT NULL REFERENCES products(id)
);


-- SEED DATA --

INSERT INTO users (id, first_name, last_name, address, birth_date, email, phone, password) VALUES
(uuid_generate_v4(), 'John', 'Doe', '123 Main St, Anytown, USA', '1980-01-01', 'john.doe@example.com', '1234567890', 'password123'),
(uuid_generate_v4(), 'Jane', 'Smith', '456 Oak St, Othertown, USA', '1990-02-02', 'jane.smith@example.com', '2345678901', 'securepassword'),
(uuid_generate_v4(), 'Alice', 'Johnson', '789 Pine St, Thistown, USA', '1985-03-03', 'alice.johnson@example.com', '3456789012', 'mypassword'),
(uuid_generate_v4(), 'Bob', 'Williams', '321 Birch St, Thatown, USA', '1975-04-04', 'bob.williams@example.com', '4567890123', 'anotherpassword'),
(uuid_generate_v4(), 'Charlie', 'Brown', '654 Cedar St, Sometown, USA', '1988-05-05', 'charlie.brown@example.com', '5678901234', 'password456'),
(uuid_generate_v4(), 'David', 'Davis', '987 Elm St, Anothertown, USA', '1992-06-06', 'david.davis@example.com', '6789012345', 'securepass123'),
(uuid_generate_v4(), 'Emma', 'Miller', '123 Spruce St, Yetanothertown, USA', '1983-07-07', 'emma.miller@example.com', '7890123456', 'password789'),
(uuid_generate_v4(), 'Frank', 'Wilson', '456 Fir St, Thisotherplace, USA', '1978-08-08', 'frank.wilson@example.com', '8901234567', 'secure1234'),
(uuid_generate_v4(), 'Grace', 'Moore', '789 Maple St, Thatotherplace, USA', '1995-09-09', 'grace.moore@example.com', '9012345678', 'mypassword456'),
(uuid_generate_v4(), 'Hank', 'Taylor', '321 Willow St, Someplaceelse, USA', '1987-10-10', 'hank.taylor@example.com', '0123456789', 'password987');

INSERT INTO products (id, name, price, description, image, color, meta, rating) VALUES
(uuid_generate_v4(), 'Product1', 19.99, 'Description of Product1', 'image1.jpg', 'Red', '{"key": "value"}', 4.5),
(uuid_generate_v4(), 'Product2', 29.99, 'Description of Product2', 'image2.jpg', 'Blue', '{"key": "value"}', 4.0),
(uuid_generate_v4(), 'Product3', 39.99, 'Description of Product3', 'image3.jpg', 'Green', '{"key": "value"}', 3.5),
(uuid_generate_v4(), 'Product4', 49.99, 'Description of Product4', 'image4.jpg', 'Yellow', '{"key": "value"}', 4.8),
(uuid_generate_v4(), 'Product5', 59.99, 'Description of Product5', 'image5.jpg', 'Black', '{"key": "value"}', 4.2),
(uuid_generate_v4(), 'Product6', 69.99, 'Description of Product6', 'image6.jpg', 'White', '{"key": "value"}', 3.9),
(uuid_generate_v4(), 'Product7', 79.99, 'Description of Product7', 'image7.jpg', 'Purple', '{"key": "value"}', 4.7),
(uuid_generate_v4(), 'Product8', 89.99, 'Description of Product8', 'image8.jpg', 'Orange', '{"key": "value"}', 4.4),
(uuid_generate_v4(), 'Product9', 99.99, 'Description of Product9', 'image9.jpg', 'Pink', '{"key": "value"}', 4.1),
(uuid_generate_v4(), 'Product10', 109.99, 'Description of Product10', 'image10.jpg', 'Brown', '{"key": "value"}', 4.6);


INSERT INTO orders (id, user_id, date, comments, status, address) VALUES
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-01-01 10:00:00', 'First order', 'pending', '123 Main St, Anytown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-02-01 11:00:00', 'Second order', 'shipped', '456 Oak St, Othertown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-03-01 12:00:00', 'Third order', 'delivered', '789 Pine St, Thistown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-04-01 13:00:00', 'Fourth order', 'pending', '321 Birch St, Thatown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-05-01 14:00:00', 'Fifth order', 'shipped', '654 Cedar St, Sometown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-06-01 15:00:00', 'Sixth order', 'delivered', '987 Elm St, Anothertown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-07-01 16:00:00', 'Seventh order', 'pending', '123 Spruce St, Yetanothertown, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-08-01 17:00:00', 'Eighth order', 'shipped', '456 Fir St, Thisotherplace, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-09-01 18:00:00', 'Ninth order', 'delivered', '789 Maple St, Thatotherplace, USA'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), '2023-10-01 19:00:00', 'Tenth order', 'pending', '321 Willow St, Someplaceelse, USA');


INSERT INTO order_detail (id, order_id, product_id) VALUES
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1));

INSERT INTO carts (id, user_id, product_id, quantity) VALUES
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 1),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 2),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 3),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 4),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 5),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 1),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 2),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 3),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 4),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 5);


INSERT INTO payments (id, order_id, method, amount) VALUES
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Credit Card', 100.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'PayPal', 50.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Bank Transfer', 200.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Credit Card', 75.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'PayPal', 150.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Bank Transfer', 120.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Credit Card', 90.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'PayPal', 130.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Bank Transfer', 110.00),
(uuid_generate_v4(), (SELECT id FROM orders ORDER BY RANDOM() LIMIT 1), 'Credit Card', 80.00);


INSERT INTO reviews (id, product_id, review, rating, image) VALUES
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Great product!', 4.5, 'review1.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Not bad', 4.0, 'review2.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Could be better', 3.5, 'review3.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Excellent!', 5.0, 'review4.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Just okay', 3.0, 'review5.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Loved it', 4.8, 'review6.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Good value for money', 4.2, 'review7.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Would recommend', 4.4, 'review8.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Not worth the price', 2.5, 'review9.jpg'),
(uuid_generate_v4(), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Very satisfied', 4.6, 'review10.jpg');

INSERT INTO wishlists (id, user_id, product_id, name) VALUES
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'John Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Jane Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Alice Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Bob Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Charlie Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'David Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Emma Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Frank Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Grace Wishlist'),
(uuid_generate_v4(), (SELECT id FROM users ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1), 'Hank Wishlist');

INSERT INTO wishlist_product (id, wishlist_id, product_id) VALUES
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1)),
(uuid_generate_v4(), (SELECT id FROM wishlists ORDER BY RANDOM() LIMIT 1), (SELECT id FROM products ORDER BY RANDOM() LIMIT 1));


-- QUERIES --

-- Select All Users
SELECT * FROM users;

-- Select All Orders with User Information
SELECT 
orders.date,
orders.status,
orders.address AS order_address,
users.first_name,
users.last_name,
users.email,
users.phone
FROM orders
JOIN users
ON orders.user_id=users.id;

-- Select All Products in an Order
SELECT
orders.id AS order_id,
orders.date,
products.name AS product_name,
products.price,
FROM orders
JOIN products
ON products.id=product_id


-- Select All Products in a User's Cart


-- Select All Payments with Order Information
SELECT
orders.date,
orders.status,
orders.address,
payments.method,
payments.amount
FROM payments
JOIN orders
ON payments.order_id=orders.id;

-- Select All Reviews for a Product
SELECT
products.name,
reviews.review,
reviews.rating
FROM products
JOIN reviews
ON products.id=product_id;

-- Select All Products in a Wishlist
SELECT
wishlists.id,
users.first_name,
users.last_name,
wishlists.name,
products.name,
products.description
FROM products
JOIN wishlists
ON  products.id=wishlists.product_id
JOIN users
ON wishlists.user_id=users.id;

-- Select All Products in a Wishlist using wishlist_product

-- Count Total Users
SELECT COUNT(*) AS total_users FROM users;

-- Count Total Orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Count Total Products
SELECT COUNT(*) AS total_products FROM products;

-- Count Total Reviews
-- Count Total Payments
-- Count Total Products in a Cart per User
-- Count Total Products in a Wishlist per User
-- Sum Total Amount Spent by User
-- Sum Total Quantity of Products in Orders
-- Group Orders by Status
-- Group Products by Color
-- Group Reviews by Rating
-- Average Rating for Each Product
-- List Users with Most Orders
-- List Products with Most Reviews
-- List Users with the Most Products in Cart
-- List Users with the Most Products in Wishlist
-- Select Orders Placed in the Last Month
-- Select Top 5 Most Expensive Products
-- Select Top 5 Highest Rated Products
-- Select Users Who Have Placed No Orders
-- Select Users Who Have Never Added Products to Cart
-- Select Users Who Have Never Added Products to Wishlist
-- Select Orders with Specific Status (e.g., 'pending')
-- Select Products with Price Above a Certain Value
-- Select Reviews with Rating Below a Certain Value
-- Select All Orders with Specific Product
-- Select All Users Who Reviewed a Specific Product
-- Select All Users Who Ordered a Specific Product
-- Select All Users Who Paid by a Specific Method
-- Select All Products Ordered in a Specific Date Range
-- Select All Orders Shipped to a Specific Address
-- Select All Users with Birthdays in a Specific Month
-- Select All Products with a Specific Color
-- Select All Products with a Specific Keyword in Description
-- Count Orders by Month
-- Count Products by Category (if category is added)
-- Average Order Value per User
-- Max and Min Price of Products
-- Select Users with Incomplete Profiles (e.g., missing phone)
-- Select Orders with Missing Address
-- List Products Not Reviewed by Any User
























