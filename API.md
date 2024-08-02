# API Documentation

## User

### Methods

#### POST: /users

**Request Body:**

```json
{
  "first_name": "",
  "last_name": "",
  "address": "",
  "birth_date": "",
  "email": "",
  "phone": "",
  "password": ""
}
```

#### POST: /users/login

**Request Body:**

```json
{
  "email": "",
  "password": ""
}
```

#### GET: /users

#### GET: /users/:id

#### PUT: /users/:id

**Request Body:**

```json
{
  "first_name": "",
  "last_name": "",
  "address": "",
  "birth_date": "",
  "email": "",
  "phone": "",
  "password": ""
}
```

#### DELETE: /users/:id

#### DELETE: /users/logout

## Products

### Methods

#### POST: /products

**Request Body:**

```json
{
  "name": "",
  "price": 0,
  "description": "",
  "images": [],
  "color": "",
  "meta": "",
  "rating": 0,
  "quantity": 0
}
```

#### GET: /products

#### GET: /products/:id

#### PUT: /products/:id

**Request Body:**

```json
{
  "name": "",
  "price": 0,
  "description": "",
  "images": [],
  "color": "",
  "meta": "",
  "rating": 0,
  "quantity": 0
}
```

#### DELETE: /products/:id

#### PATCH: /products/:id

**Request Body:**

```json
{
  "quantity": 0
}
```

## Orders

### Methods

#### POST: /orders

**Request Body:**

```json
{
  "user_id": "",
  "date_time": "",
  "comments": "",
  "status": 0,
  "address": ""
}
```

#### GET: /orders

#### GET: /orders/:id

#### PUT: /orders/:id

**Request Body:**

```json
{
  "user_id": "",
  "date_time": "",
  "comments": "",
  "status": 0,
  "address": ""
}
```

#### DELETE: /orders/:id

## Wishlist

### Methods

#### POST: /wishlists

**Request Body:**

```json
{
  "user_id": "",
  "name": ""
}
```

#### GET: /wishlists

#### GET: /wishlists/:id

#### PATCH: /wishlists/:id

**Request Body:**

```json
{
  "name": ""
}
```

#### DELETE: /wishlists/:id

## Cart

### Methods

#### POST: /carts

**Request Body:**

```json
{
  "user_id": "",
  "products": [{ "product_id": "", "quantity": 0 }]
}
```

#### GET: /carts/:userId

#### DELETE: /carts/:userId

## Payment

### Methods

#### POST: /payments

**Request Body:**

```json
{
  "order_id": "",
  "method": 0,
  "amount": 0
}
```

#### GET: /payments/:userId

#### GET: /payments/:id

## Review

### Methods

#### POST: /reviews

**Request Body:**

```json
{
  "product_id": "",
  "review": "",
  "rating": 0,
  "images": []
}
```

#### PUT: /reviews/:id

**Request Body:**

```json
{
  "review": "",
  "rating": 0,
  "images": []
}
```

#### GET: /reviews/:userId

#### GET: /reviews/:productId

#### DELETE: /reviews/:id
