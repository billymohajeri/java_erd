CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(255),
    birth_date DATE,
    email VARCHAR(70) NOT NULL UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    date TIMESTAMP NOT NULL,
    comments TEXT,
    status VARCHAR(30) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    color VARCHAR(50) NOT NULL,
    meta JSON,
    rating NUMERIC(3,2)
);































