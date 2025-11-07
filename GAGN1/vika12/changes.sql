-- Fjarlægjum töflur ef þær eru þegar til, svo við getum keyrt þetta aftur og aftur
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS pizzas;

-- Tafla fyrir allar pítsur sem eru í boði
CREATE TABLE pizzas (
    pizza_id SERIAL PRIMARY KEY,
    pizza_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Tafla fyrir pantanir
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Samskeytatöflu (Junction Table) fyrir pöntunarlínur
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    -- 'order_id' vísar í pöntunina sem þessi lína tilheyrir
    order_id INT NOT NULL,
    -- 'pizza_id' vísar í pítsuna sem var pöntuð
    pizza_id INT NOT NULL,
    quantity INT NOT NULL,
    
    -- Heilleikareglur (Constraints)
    CONSTRAINT fk_order FOREIGN KEY(order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_pizza FOREIGN KEY(pizza_id) REFERENCES pizzas(pizza_id)
);

-- Setjum inn þær pítsur sem við þurfum fyrir dæmið
INSERT INTO pizzas (pizza_name, price) VALUES
('Pepperoni', 2500), -- pizza_id = 1
('Hawaii', 2300),    -- pizza_id = 2
('Margarita', 2100); -- pizza_id = 3

-- Staðfestum að pítsurnar séu komnar inn
SELECT * FROM pizzas;