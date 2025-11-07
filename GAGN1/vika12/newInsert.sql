INSERT INTO customers (first_name, last_name, email, phone, address)
VALUES
    ('Jón', 'Jónsson', 'jon@example.com', '555-1234', 'Aðalgata 1'),
    ('Guðrún', 'Pálsdóttir', 'gudrun@example.is', '555-5678', 'Hraunbær 10'),
    ('Kalli', 'Verkfræðingur', 'kalli@verk.is', '555-9999', NULL);

SELECT * FROM customers;


INSERT INTO pizzas (name, description, price)
VALUES
    ('Pepperoni', 'Klassísk pepperoni pítsa með pepperoni og osti.', 2500.00),
    ('Hawaii', 'Hin umdeilda. Skinka og ananas.', 2300.00),
    ('Margarita', 'Tómatsósa, ostur og basilika.', 2100.00),
    ('Vegan ástin', 'Grænmetispítsa með vegan osti og fersku grænmeti.', 2700.00);

SELECT * FROM pizzas;


INSERT INTO ingredients (name, portion_size, price, is_vegan)
VALUES
    ('Pítsabotn', 1, 300, TRUE),
    ('Tómatsósa', 1, 150, TRUE),
    ('Ostur (Mozzarella)', 1, 250, FALSE),
    ('Vegan Ostur', 1, 350, TRUE),
    ('Pepperoni', 1, 300, FALSE),
    ('Skinka', 1, 280, FALSE),
    ('Ananas', 1, 100, TRUE),
    ('Basilika', 1, 50, TRUE);

SELECT * FROM ingredients;


INSERT INTO pizza_ingredients (pizza_id, ingredient_id)
VALUES
    ((SELECT pizza_id FROM pizzas WHERE name = 'Pepperoni'), (SELECT ingredient_id FROM ingredients WHERE name = 'Pítsabotn')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Pepperoni'), (SELECT ingredient_id FROM ingredients WHERE name = 'Tómatsósa')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Pepperoni'), (SELECT ingredient_id FROM ingredients WHERE name = 'Ostur (Mozzarella)')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Pepperoni'), (SELECT ingredient_id FROM ingredients WHERE name = 'Pepperoni')),

    ((SELECT pizza_id FROM pizzas WHERE name = 'Hawaii'), (SELECT ingredient_id FROM ingredients WHERE name = 'Pítsabotn')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Hawaii'), (SELECT ingredient_id FROM ingredients WHERE name = 'Tómatsósa')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Hawaii'), (SELECT ingredient_id FROM ingredients WHERE name = 'Ostur (Mozzarella)')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Hawaii'), (SELECT ingredient_id FROM ingredients WHERE name = 'Skinka')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Hawaii'), (SELECT ingredient_id FROM ingredients WHERE name = 'Ananas')),

    ((SELECT pizza_id FROM pizzas WHERE name = 'Vegan ástin'), (SELECT ingredient_id FROM ingredients WHERE name = 'Pítsabotn')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Vegan ástin'), (SELECT ingredient_id FROM ingredients WHERE name = 'Tómatsósa')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Vegan ástin'), (SELECT ingredient_id FROM ingredients WHERE name = 'Vegan Ostur')),
    ((SELECT pizza_id FROM pizzas WHERE name = 'Vegan ástin'), (SELECT ingredient_id FROM ingredients WHERE name = 'Basilika'));

SELECT 
    p.name AS pizza, 
    i.name AS ingredient
FROM pizza_ingredients pi
JOIN pizzas p ON pi.pizza_id = p.pizza_id
JOIN ingredients i ON pi.ingredient_id = i.ingredient_id;


BEGIN TRANSACTION;

WITH 
    p1_price AS (
        SELECT price FROM pizzas WHERE name = 'Pepperoni'
    ),
    p2_price AS (
        SELECT price FROM pizzas WHERE name = 'Margarita'
    ),

    order_total_calc AS (
        SELECT 
            ( (SELECT price FROM p1_price) * 1 ) + 
            ( (SELECT price FROM p2_price) * 2 ) AS total
    ),

    new_order AS (
        INSERT INTO orders (customer_id, order_total, order_status)
        VALUES (
            (SELECT customer_id FROM customers WHERE email = 'gudrun@example.is'),
            (SELECT total FROM order_total_calc),
            'In Progress'
        )
        RETURNING order_id
    )

INSERT INTO order_items (order_id, pizza_id, quantity, unit_price)
VALUES
    (
        (SELECT order_id FROM new_order),
        (SELECT pizza_id FROM pizzas WHERE name = 'Pepperoni'),
        1,
        (SELECT price FROM p1_price)
    ),
    (
        (SELECT order_id FROM new_order),
        (SELECT pizza_id FROM pizzas WHERE name = 'Margarita'),
        2,
        (SELECT price FROM p2_price)
    );

COMMIT;

SELECT 
    o.order_id, 
    c.first_name, 
    o.order_total, 
    o.order_status,
    STRING_AGG(p.name || ' (x' || oi.quantity || ')', ', ') AS order_summary
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
GROUP BY o.order_id, c.customer_id;