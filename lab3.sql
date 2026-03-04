-- 10.1 
SELECT name, surname, PESEL, born, u.user_id FROM User AS u 
JOIN UserGoods AS ug ON u.user_id = ug.user_id 
JOIN Goods AS g ON ug.goods_id = g.goods_id 
WHERE g.product = 'hair dryer';

SELECT * FROM User 
WHERE user_id IN
	(SELECT user_id FROM UserGoods 
	WHERE goods_id = (
		SELECT goods_id FROM Goods WHERE product = 'hair dryer'));

-- 10.2
SELECT * FROM User
WHERE user_id NOT IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'refrigerator');
	
SELECT * FROM User 
WHERE user_id NOT IN
	(SELECT user_id FROM UserGoods 
	WHERE goods_id = (
		SELECT goods_id FROM Goods WHERE product = 'refrigerator'));
		
-- 10.3
SELECT * FROM User
WHERE user_id IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'satellite tuner'
)
AND user_id IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'tv'
);

SELECT * FROM User WHERE user_id IN (
	(SELECT user_id from UserGoods 
	WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'tv'))
		INTERSECT
	(SELECT user_id from UserGoods 
	WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'satellite tuner'))
	);

-- 10.4
SELECT * FROM User
WHERE user_id IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'satellite tuner' OR g.product = 'tv');
	
SELECT * FROM User WHERE user_id IN (
	(SELECT user_id from UserGoods 
	WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'tv'))
		UNION
	(SELECT user_id from UserGoods 
	WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'satellite tuner'))
	);

-- 10.5
SELECT * FROM User
WHERE user_id IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'satellite tuner' OR g.product = 'tv'
	GROUP BY u.user_id
	HAVING COUNT(DISTINCT product) = 1);

	
SELECT * FROM User
WHERE user_id IN (
        SELECT user_id FROM UserGoods
        WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'tv')
        AND user_id NOT IN (
            SELECT user_id FROM UserGoods
            WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'satellite tuner')
        )
    )
UNION
SELECT * FROM User
WHERE user_id IN (
        SELECT user_id FROM UserGoods
        WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'satellite tuner')
        AND user_id NOT IN (
            SELECT user_id FROM UserGoods
            WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'tv')
        )
    );

-- 10.6
SELECT * FROM User
WHERE user_id IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'tv')
	AND user_id NOT IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	WHERE g.product = 'washing machine'
);

SELECT * FROM User
WHERE user_id IN (
        SELECT user_id FROM UserGoods
        WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'tv')
        AND user_id NOT IN (
            SELECT user_id FROM UserGoods
            WHERE goods_id = (SELECT goods_id FROM Goods WHERE product = 'washing machine')
        )
    );
    
-- 10.7
SELECT * FROM User
WHERE user_id IN (
	SELECT u.user_id FROM User AS u
	JOIN UserGoods AS ug ON u.user_id = ug.user_id
	JOIN Goods AS g ON ug.goods_id = g.goods_id
	GROUP BY user_id
	HAVING COUNT(DISTINCT product) = (
		SELECT MAX(number) FROM (
			SELECT COUNT(DISTINCT product) AS number FROM User AS u
			JOIN UserGoods AS ug ON u.user_id = ug.user_id
			JOIN Goods AS g ON ug.goods_id = g.goods_id
			GROUP BY u.user_id) 
			AS sub)
			);
			
SELECT * FROM User
WHERE user_id IN (
    SELECT user_id FROM UserGoods
    GROUP BY user_id
    HAVING COUNT(*) = (
        SELECT MAX(number)
        FROM (
            SELECT user_id, COUNT(*) AS number
            FROM UserGoods
            GROUP BY user_id
        ) AS sub
    )
);
	
-- 10.8
SELECT * FROM Vendor AS v
LEFT JOIN GoodsVendor AS gv ON v.vendor_id = gv.vendor_id
LEFT JOIN Goods AS g ON gv.goods_id = g.goods_id
GROUP BY v.vendor_id
HAVING COUNT(g.goods_id) = 0;

SELECT * FROM Vendor
WHERE vendor_id NOT IN (
    SELECT vendor_id FROM GoodsVendor
    );

-- 11
SELECT DISTINCT m.name AS male, f.name AS female FROM User AS m 
CROSS JOIN User AS f 
WHERE m.name NOT LIKE '%a' AND f.name LIKE '%a';

SELECT DISTINCT m.name AS male, f.name AS female 
FROM User AS m, User AS f 
WHERE m.name NOT LIKE '%a' AND f.name LIKE '%a';