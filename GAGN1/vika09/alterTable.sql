ALTER TABLE pizzaingredients
ADD CONSTRAINT fk_idPizza_PI
FOREIGN KEY (idPizza)
REFERENCES pizzas (id);