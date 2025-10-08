SELECT firstName, lastName, email
FROM customers
;

SELECT firstName, lastName, email 
FROM customers
WHERE firstName = 'Jón';

SELECT firstName, lastName, email, id
FROM customers
WHERE id > 1;

SELECT firstName, lastName, email, id
FROM customers
WHERE id > 1 OR firstName = 'Jón';

SELECT pizzas.name, ingredients.name
FROM 
    pizzas 
        INNER JOIN 
    pizzaIngredients
        ON pizzas.id = pizzaIngredients.idPizza
        INNER JOIN 
    ingredients
        ON pizzaIngredients.idIngredients = ingredients.id;


SELECT 
    customers.firstName, customers.lastName,
    pizzas.name, pizzas.price
FROM
    customers
        INNER JOIN
    pizzaOrders
        ON customers.id = pizzaOrders.idCustomer
        INNER JOIN 
    pizzas
        ON pizzaOrders.idPizza = pizzas.id;


SELECT pizzas.name, ingredients.name
FROM 
    pizzas 
        INNER JOIN 
    pizzaIngredients
        ON pizzas.id = pizzaIngredients.idPizza
        INNER JOIN 
    ingredients
        ON pizzaIngredients.idIngredients = ingredients.id
WHERE
    pizzas.price > 15;

SELECT * FROM pizzas;

SELECT pizzas.name, ingredients.name
FROM 
    pizzas 
        INNER JOIN 
    pizzaIngredients
        ON pizzas.id = pizzaIngredients.idPizza
        INNER JOIN 
    ingredients
        ON pizzaIngredients.idIngredients = ingredients.id;