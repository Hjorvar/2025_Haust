DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS pizza_ingredients;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS pizzas;
DROP TABLE IF EXISTS customers;
















CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(55) NOT NULL,
    last_name VARCHAR(55) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email LIKE '%_@_%._%'),
    phone VARCHAR(55),
    address VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);




















CREATE TABLE pizzas (
    pizza_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0)
);






















CREATE TABLE ingredients (
    ingredient_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    portion_size SMALLINT NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    is_vegan BOOLEAN NOT NULL DEFAULT FALSE
);












CREATE TABLE pizza_ingredients (
    pizza_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    
    CONSTRAINT fk_pizza 
        FOREIGN KEY(pizza_id) 
        REFERENCES pizzas(pizza_id)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_ingredient 
        FOREIGN KEY(ingredient_id) 
        REFERENCES ingredients(ingredient_id)
        ON DELETE RESTRICT,
        
    PRIMARY KEY(pizza_id, ingredient_id)
);











CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_total NUMERIC(10, 2) NOT NULL CHECK (order_total > 0),
    order_status VARCHAR(20) NOT NULL DEFAULT 'Pending' 
        CHECK (order_status IN ('Pending', 'In Progress', 'Out for Delivery', 'Completed', 'Cancelled')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_customer 
        FOREIGN KEY(customer_id) 
        REFERENCES customers(customer_id)
        ON DELETE SET NULL
);


CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL,
    
    CONSTRAINT fk_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_pizza
        FOREIGN KEY(pizza_id)
        REFERENCES pizzas(pizza_id)
        ON DELETE RESTRICT
);