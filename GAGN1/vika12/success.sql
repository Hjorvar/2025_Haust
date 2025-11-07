/*
 * ATBURÐARÁS A: PÖNTUN SEM HEPPNAST
 * Markmið: Búa til pöntun (orders) OG pöntunarlínur (order_items)
 * sem eina órofa aðgerð (Atomicity).
 */
BEGIN TRANSACTION; -- Hefjum færsluna 

-- Búum til pöntunina og fáum nýja order_id til baka.
-- Þetta er sett inn í Common Table Expression (CTE) sem heitir 'new_order'.
WITH new_order AS (
    INSERT INTO orders (customer_id, order_total)
    VALUES (1, 7300.00)
    RETURNING order_id -- Þessi skipun skilar nýja ID-inu
)
-- Setjum pöntunarlínurnar inn og notum 'order_id' úr CTE-inu hér að ofan
INSERT INTO order_items (order_id, pizza_id, quantity)
VALUES
    ((SELECT order_id FROM new_order), 1, 2), -- 2x Pepperoni (pizza_id 1)
    ((SELECT order_id FROM new_order), 2, 1); -- 1x Hawaii (pizza_id 2)

-- Allt tókst! Við vistum breytingarnar varanlega.
COMMIT;

-- Kóði til að staðfesta (keyra sér):
-- SELECT * FROM orders ORDER BY order_id DESC LIMIT 1;
-- SELECT * FROM order_items WHERE order_id = (SELECT MAX(order_id) FROM orders);