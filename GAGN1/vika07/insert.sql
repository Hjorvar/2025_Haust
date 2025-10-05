INSERT INTO pizzas (name, description, price)
VALUES ('Margarita', 'Bara sósa og ostur', 50000),
('Pepparoni veisla', 'Hérna færðu mikið pepparóní', 500),
('Vegan veisla', 'Besta vegan pítsan sem þú hefur fengið, með papriku, sveppum og ólífum', 5);

SELECT * FROM pizzas;

INSERT INTO ingredients (name, portionSize, price, isVegan)
VALUES ('pizza sósan', 20, 10, TRUE),
('ostur', 50, 100000, FALSE),
('pepparóni - lítið', 30, 250, FALSE),
('paprika', 20, 300, TRUE),
('sveppir', 20, 300, TRUE),
('ólífur', 2, 300, TRUE);

SELECT * FROM ingredients;

INSERT INTO pizzaIngredients (idPizza, idIngredients)
VALUES (1, 1), (1, 2), (3, 1), (3, 4), (3, 5), (3, 6);

SELECT pizzas.name, pizzas.description, ingredients.name
FROM pizzas INNER JOIN pizzaIngredients
ON pizzas.id = pizzaIngredients.idPizza
INNER JOIN ingredients
ON pizzaIngredients.idIngredients = ingredients.id;


INSERT INTO customers (firstName, lastName, email, phone, address)
VALUES ('Jón', 'Sigurðsson', 'js@fb.is', '5554950', 'Beljuland 10'),
('Karl', 'Magnússson', 'km@fb.is', '5552487', 'Dúfnahólar 10'),
('Hjörvar Ingi', 'Haraldsson', 'hih@fb.is', '5552343', 'Kirkjustræti 11');

INSERT INTO pizzaOrders(idCustomer, idPizza)
VALUES (2, 3);