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

-- Bætum við fleiri hráefnum fyrir fjölbreyttari pítsur
INSERT INTO ingredients (name, portionSize, price, isVegan)
VALUES 
('skinka', 40, 350, FALSE),
('ananas', 30, 200, TRUE),
('hreindýrakjöt', 50, 800, FALSE),
('rjómaostur', 30, 250, FALSE),
('sultutau', 15, 150, TRUE),
('rækjur', 40, 400, FALSE),
('hvítlauksolía', 10, 100, TRUE);

-- Bætum við þremur nýjum pítsum í vöruúrvalið
INSERT INTO pizzas (name, description, price)
VALUES 
('Hawaii', 'Hin sígilda með skinku og ananas', 5500),
('Hreindýraveisla', 'Sérréttur hússins með hreindýrakjöti, rjómaosti og sultu', 7500),
('Sjávarrétta', 'Með rækjum og hvítlauksolíu', 6200);

-- Fyrst klárum við "Pepparoni veisla" (pizza með id=2)
INSERT INTO pizzaIngredients (idPizza, idIngredients)
VALUES 
(2, 1), -- pizza sósan
(2, 2), -- ostur
(2, 3); -- pepparóní

-- Tengjum hráefni við nýju pítsurnar
-- Hawæi (pizza með id=4)
INSERT INTO pizzaIngredients (idPizza, idIngredients)
VALUES 
(5, 1), -- pizza sósan
(5, 2), -- ostur
(5, 7), -- skinka
(5, 8); -- ananas

-- Hreindýraveisla (pizza með id=5)
INSERT INTO pizzaIngredients (idPizza, idIngredients)
VALUES 
(6, 9),  -- hreindýrakjöt
(6, 10), -- rjómaostur
(6, 11); -- sultutau

-- Sjávarrétta (pizza með id=6)
INSERT INTO pizzaIngredients (idPizza, idIngredients)
VALUES 
(7, 2),  -- ostur
(7, 12), -- rækjur
(7, 13); -- hvítlauksolía

SELECT * FROM pizzas;

-- Bætum við tveimur nýjum viðskiptavinum
INSERT INTO customers (firstName, lastName, email, phone, address)
VALUES 
('Guðrún', 'Jónsdóttir', 'gj@fb.is', '5558888', 'Blómsturvellir 2'),
('Pétur', 'Pálsson', 'pp@fb.is', '5559999', 'Lautarvegur 19');

-- Bætum við fleiri pöntunum til að fylla gagnagrunninn
INSERT INTO pizzaOrders(idCustomer, idPizza)
VALUES 
(1, 1), -- Jón pantar Margaritu
(3, 2), -- Hjörvar pantar Pepparoni veislu
(4, 4), -- Guðrún pantar Hawæi
(5, 5), -- Pétur pantar Hreindýraveislu
(1, 3), -- Jón pantar líka Vegan veislu
(2, 6); -- Karl pantar Sjávarrétta