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
    user_id UUID NOT NULL UNIQUE REFERENCES billyApp.user(id)
);


CREATE TABLE IF NOT EXISTS billyApp.cart_product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cart_id UUID NOT NULL REFERENCES billyApp.cart(id),
    product_id UUID NOT NULL REFERENCES billyApp.product(id),
    quantity INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS billyApp.payment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES billyApp.order(id),
    method INTEGER NOT NULL,
    amount NUMERIC(10,2) NOT NULL
);


CREATE TABLE IF NOT EXISTS billyApp.review (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES billyApp.user(id),
    product_id UUID NOT NULL REFERENCES billyApp.product(id),
    review TEXT NOT NULL,
    rating NUMERIC(2,1),
    image TEXT[]
);


CREATE TABLE IF NOT EXISTS billyApp.wishlist (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL UNIQUE REFERENCES billyApp.user(id),
    product_id UUID NOT NULL REFERENCES billyApp.product(id)
);


CREATE TABLE IF NOT EXISTS billyApp.wishlist_product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    wishlist_id UUID NOT NULL REFERENCES billyApp.wishlist(id),
    product_id UUID NOT NULL REFERENCES billyApp.product(id)
);


\dt billyApp.*

\d billyApp.*


-- SEED DATA --

INSERT INTO billyApp.user (first_name, last_name, address, birth_date, email, phone, password) VALUES
('John', 'Doe', '123 Main St, Anytown, USA', '1980-01-01', 'john.doe@example.com', '1234567890', 'password123'),
('Jane', 'Smith', '456 Oak St, Othertown, USA', '1990-02-02', 'jane.smith@example.com', '2345678901', 'securepassword'),
('Alice', 'Johnson', '789 Pine St, Thistown, USA', '1985-03-03', 'alice.johnson@example.com', '3456789012', 'mypassword'),
('Bob', 'Williams', '321 Birch St, Thatown, USA', '1975-04-04', 'bob.williams@example.com', '4567890123', 'anotherpassword'),
('Charlie', 'Brown', '654 Cedar St, Sometown, USA', '1988-05-05', 'charlie.brown@example.com', '5678901234', 'password456'),
('David', 'Davis', '987 Elm St, Anothertown, USA', '1992-06-06', 'david.davis@example.com', '6789012345', 'securepass123'),
('Emma', 'Miller', '123 Spruce St, Yetanothertown, USA', '1983-07-07', 'emma.miller@example.com', '7890123456', 'password789'),
('Frank', 'Wilson', '456 Fir St, Thisotherplace, USA', '1978-08-08', 'frank.wilson@example.com', '8901234567', 'secure1234'),
('Grace', 'Moore', '789 Maple St, Thatotherplace, USA', '1995-09-09', 'grace.moore@example.com', '9012345678', 'mypassword456'),
('Hank', 'Taylor', '321 Willow St, Someplaceelse, USA', '1987-10-10', 'hank.taylor@example.com', '0123456789', 'password987');


INSERT INTO billyApp.product (name, price, description, images, color, meta, rating, stock) VALUES
('Product1', 19.99, 'Description of Product1', '{"image1.jpg"}', 'Red', '{"key": "value"}', 4.5, 14),
('Product2', 29.99, 'Description of Product2', '{"image2.jpg"}', 'Blue', '{"key": "value"}', 4.0, 14),
('Product3', 39.99, 'Description of Product3', '{"image3.jpg"}', 'Green', '{"key": "value"}', 3.5, 14),
('Product4', 49.99, 'Description of Product4', '{"image4.jpg"}', 'Yellow', '{"key": "value"}', 4.8, 14),
('Product5', 59.99, 'Description of Product5', '{"image5.jpg"}', 'Black', '{"key": "value"}', 4.2, 14),
('Product6', 69.99, 'Description of Product6', '{"image6.jpg"}', 'White', '{"key": "value"}', 3.9, 14),
('Product7', 79.99, 'Description of Product7', '{"image7.jpg"}', 'Purple', '{"key": "value"}', 4.7, 14),
('Product8', 89.99, 'Description of Product8', '{"image8.jpg"}', 'Orange', '{"key": "value"}', 4.4, 14),
('Product9', 99.99, 'Description of Product9', '{"image9.jpg"}', 'Pink', '{"key": "value"}', 4.1, 14),
('Product10', 109.99, 'Description of Product10', '{"image10.jpg"}', 'Brown', '{"key": "value"}', 4.6, 14);


INSERT INTO billyApp.order (user_id, date_time, comments, status, address) VALUES
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-01-01 10:00:00', 'First order', 0, '123 Main St, Anytown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-02-01 11:00:00', 'Second order', 1, '456 Oak St, Othertown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-03-01 12:00:00', 'Third order', 2, '789 Pine St, Thistown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-04-01 13:00:00', 'Fourth order', 3, '321 Birch St, Thatown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-05-01 14:00:00', 'Fifth order', 4, '654 Cedar St, Sometown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-06-01 15:00:00', 'Sixth order', 0, '987 Elm St, Anothertown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-07-01 16:00:00', 'Seventh order', 1, '123 Spruce St, Yetanothertown, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-08-01 17:00:00', 'Eighth order', 2, '456 Fir St, Thisotherplace, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-09-01 18:00:00', 'Ninth order', 3, '789 Maple St, Thatotherplace, USA'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), '2023-10-01 19:00:00', 'Tenth order', 4, '321 Willow St, Someplaceelse, USA');


INSERT INTO billyApp.order_product (order_id, product_id) VALUES
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1));


INSERT INTO billyApp.cart (user_id) VALUES
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1));


INSERT INTO billyApp.payment (order_id, method, amount) VALUES
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 1, 100.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 2, 50.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 3, 200.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 4, 75.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 100, 150.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 713, 120.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 5, 90.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 412, 130.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 7, 110.00),
((SELECT id FROM billyApp.order ORDER BY RANDOM() LIMIT 1), 11, 80.00);


INSERT INTO billyApp.review (user_id, product_id, review, rating, image) VALUES
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Great product!', 4.5, '{"review1.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Not bad', 4.0, '{"review2.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Could be better', 3.5, '{"review3.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Excellent!', 5.0, '{"review4.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Just okay', 3.0, '{"review5.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Loved it', 4.8, '{"review6.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Good value for money', 4.2, '{"review7.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Would recommend', 4.4, '{"review8.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Not worth the price', 2.5, '{"review9.jpg"}'),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1), 'Very satisfied', 4.6, '{"review10.jpg"}');


INSERT INTO billyApp.wishlist (user_id, product_id) VALUES
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.user ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1));


INSERT INTO billyApp.wishlist_product (wishlist_id, product_id) VALUES
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1)),
((SELECT id FROM billyApp.wishlist ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1));


INSERT INTO billyApp.cart_product (cart_id, product_id, quantity) VALUES
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),4),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),41),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),43),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),455),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),4777),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),454),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),454),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),44),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),5414),
((SELECT id FROM billyApp.cart ORDER BY RANDOM() LIMIT 1), (SELECT id FROM billyApp.product ORDER BY RANDOM() LIMIT 1),14);


-- QUERIES --

-- Select All Data

SELECT * FROM billyApp.cart;
SELECT * FROM billyApp.cart_product;
SELECT * FROM billyApp.order;
SELECT * FROM billyApp.order_product;
SELECT * FROM billyApp.payment;
SELECT * FROM billyApp.product;
SELECT * FROM billyApp.review;
SELECT * FROM billyApp.user;
SELECT * FROM billyApp.wishlist;
SELECT * FROM billyApp.wishlist_product;


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























