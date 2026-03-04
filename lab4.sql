-- 8a
SELECT name, surname, PESEL, product FROM User AS u
JOIN UserGoods AS ug ON u.user_id = ug.user_id
JOIN Goods AS g ON ug.goods_id = g.goods_id
ORDER BY surname, name, PESEL, product;

-- 8b
SELECT product, COUNT(g.goods_id) AS number FROM Goods AS g
LEFT JOIN UserGoods AS ug ON g.goods_id = ug.goods_id
LEFT JOIN User AS u ON ug.user_id = u.user_id
GROUP BY product
ORDER BY number DESC, product;

-- 8c
SELECT name, COUNT(g.goods_id) AS number FROM Vendor AS v
LEFT JOIN GoodsVendor AS gv ON v.vendor_id = gv.vendor_id
LEFT JOIN Goods AS g ON gv.goods_id = g.goods_id
GROUP BY name
ORDER BY number DESC, name;

-- 8d
SELECT name, surname, PESEL, COUNT(g.goods_id) AS number FROM User AS u
LEFT JOIN UserGoods AS ug ON u.user_id = ug.user_id
LEFT JOIN Goods AS g ON ug.goods_id = g.goods_id
GROUP BY u.user_id
ORDER BY number DESC, surname, name, PESEL, product;