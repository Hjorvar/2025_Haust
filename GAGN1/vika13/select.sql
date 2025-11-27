SELECT
 *
FROM
    pizzas
        JOIN
    pizza_ingredients
        ON pizzas.pizza_id = pizza_ingredients.pizza_id
        JOIN
    ingredients
        ON pizza_ingredients.ingredient_id = ingredients.ingredient_id;