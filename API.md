# API Documentation

## User

### Methods


#### POST: /users
**Request Body:**
```json
{
first_name:"",
last_name:"",
address:"",
birth_date:"",
email:"",
phone:"",
password:"",
}

POST: /users/login
Request body: {
email:"",
password:"",
}

GET: /users
GET: /users/:id

PUT: /users/:id
Request body: {
first_name:"",
last_name:"",
address:"",
birth_date:"",
email:"",
phone:"",
password:"",
}

DELETE: /users/:id

DELETE: /users/logout

Resource: Products
Methods:
POST: /products
Request body: {
name:"",
price:0,
description:"",
images:[],
color:"",
meta:"",
rating:0,
quantity:0,
}
GET: /products
GET: /products/:id

PUT: /products/:id
Request body: {
name:"",
price:0,
description:"",
images:[],
color:"",
meta:"",
rating:0,
quantity:0,
}

DELETE: /products/:id

PATCH: /products/:id
Request body: {
quantity:0,
}

Resource: Orders
Methods:
POST: /orders
Request body: {
user_id:"",
date_time:"",
comments:"",
status:0,
address:"",
}
GET: /orders
GET: /orders/:id

PUT: /orders/:id
Request body: {
user_id:"",
date_time:"",
comments:"",
status:0,
address:"",
}

DELETE: /orders/:id

Resource: Wishlist
Methods:
POST: /wishlists
Request body: {
user_id:"",
name:"",
}
GET: /wishlists
GET: /wishlists/:id

PATCH: /wishlists/:id
Request body: {
name:"",
}

DELETE: /wishlists/:id

Resource: Cart
Methods:
POST: /carts
Request body: {
user_id:"",
products:[
{product_id: "", quantity: 0}
],
}

GET: /carts/:userId

DELETE: /carts/:userId

Resource: Payment
Methods:
POST: /payments
Request body: {
order_id: "",
method: 0,
amount: 0,
}

GET: /payments/:userId

GET: /payments/:id

Resource: Review
Methods:
POST: /reviews
Request body: {
product_id: "",
review: "",
rating: 0,
images: [],
}

PUT: /reviews/:id
Request body: {
review: "",
rating: 0,
images: [],
}

GET: /reviews/:userId
GET: /reviews/:productId

DELETE: /reviews/:id