/*
 * ATBURÐARÁS B: PÖNTUN SEM MISTEKST (eða er hætt við)
 * Markmið: Sýna fram á að ef færsla er ekki samþykkt (COMMITTED),
 * er öllum breytingum afturkallað.
 */
BEGIN TRANSACTION; -- Hefjum færsluna 

-- Segjum að við náum að búa til pöntunina
INSERT INTO orders (customer_id, order_total)
VALUES (2, 2100.00);

-- ... en svo gerist eitthvað. Villa! Eða viðskiptavinurinn hættir við.
-- Í stað þess að keyra 'COMMIT', þá framkvæmum við 'ROLLBACK'.
ROLLBACK; -- Hættum við allar breytingar síðan 'BEGIN' 

-- Kóði til að staðfesta (keyra sér):
-- Hér ættir þú að sjá að pöntunin með order_total = 2100
-- er HVERGI að finna. Hún var aldrei vistuð varanlega.
-- SELECT * FROM orders WHERE customer_id = 2 AND order_total = 2100;