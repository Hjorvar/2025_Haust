CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(55),
    lastName VARCHAR(55),
    email VARCHAR(255),
    phone VARCHAR(255),
    address VARCHAR(255)  
);

CREATE TABLE pizzas (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    description VARCHAR(255),
    price INTEGER
);

CREATE TABLE pizzaOrders (
    id SERIAL PRIMARY KEY,
    idPizza INTEGER,
    idCustomer INTEGER
);

CREATE TABLE ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    portionSize SMALLINT,
    price INTEGER,
    isVegan BOOLEAN
);

CREATE TABLE pizzaIngredients (
    idPizza INTEGER,
    idIngredients INTEGER
);

DROP TABLE pizzas;