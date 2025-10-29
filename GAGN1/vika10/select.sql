-- Birtum fullt nafn og heimilsfang á viðskiptavinum ef heimilisfang inniheldur land eða stræti
-- Og röðum eftir eftirnafni

SELECT
    firstName,
    lastName,
    address
FROM
    customers
WHERE
    address LIKE '%land%' OR address LIKE '%stræti%'
ORDER BY
    lastName;











-- Pantanir hjá viðskiptavinum

SELECT 
    c.firstName,
    c.lastName,
    p.name AS pizzaName
FROM 
    pizzaOrders po
INNER JOIN 
    customers c ON po.idCustomer = c.id
INNER JOIN 
    pizzas p ON po.idPizza = p.id;















SELECT
    c.firstName,
    c.lastName,
    COUNT(*) AS totalOrders
FROM
    customers c
INNER JOIN
    pizzaOrders po ON c.id = po.idCustomer
GROUP BY
    c.id
ORDER BY
    totalOrders DESC;














SELECT
    c.firstName,
    c.lastName,
    COUNT(*) AS totalOrders
FROM
    customers c
INNER JOIN
    pizzaOrders po ON c.id = po.idCustomer
GROUP BY
    c.id
HAVING
    COUNT(*) > 1;














SELECT
    p.name AS pizzaName,
    p.price,
    STRING_AGG(i.name, ', ') AS ingredients
FROM
    pizzas p
INNER JOIN
    pizzaIngredients pi ON p.id = pi.idPizza
INNER JOIN
    ingredients i ON pi.idIngredients = i.id
GROUP BY
    p.id
ORDER BY
    p.name;















SELECT 
    p_outer.name,
    p_outer.price,
    (
        SELECT 
            ROUND(AVG(p_inner.price), 0) 
        FROM 
            pizzas p_inner 
        WHERE 
            p_inner.id != p_outer.id
    ) AS averagePriceOfOtherPizzas
FROM 
    pizzas p_outer
ORDER BY
    p_outer.price DESC;