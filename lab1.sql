-- 3A)
SELECT DISTINCT publisher FROM books WHERE topic='Java' OR topic='Perl';

SELECT DISTINCT publisher FROM books WHERE topic IN ('Java', 'Perl');

-- na zbiorach:

(SELECT DISTINCT publisher FROM books WHERE topic = ‘Java’) UNION (SELECT DISTINCT publisher FROM books WHERE topic = ‘Perl’);

select distinct publisher from books where publisher in (select
distinct publisher from books where topic = "Java") or publisher in
(select distinct publisher from books where topic = "Perl");

-- 3B)
SELECT publisher FROM books WHERE topic IN ('Java', 'Perl') GROUP BY publisher HAVING COUNT(DISTINCT topic) = 2;

SELECT DISTINCT publisher FROM books WHERE publisher IN (SELECT DISTINCT publisher FROM books WHERE topic = ‘Java’) AND topic = ‘Perl’;

(SELECT DISTINCT publisher FROM books WHERE topic = ‘Java’) INTERSECT (SELECT DISTINCT publisher FROM books WHERE topic = ‘Perl’);

-- 3C) 
SELECT publisher FROM books WHERE topic IN ('Java', 'Perl') GROUP BY publisher HAVING COUNT(DISTINCT topic) = 1;

SELECT DISTINCT publisher FROM books WHERE topic = “Java’ XOR topic = ‘Perl’;

((select distinct publisher from books where topic = "Perl") except
(select distinct publisher from books where topic = "Java")) union
((select distinct publisher from books where topic = "Java") except
(select distinct publisher from books where topic = "Perl"));

-- 3D) 
SELECT DISTINCT publisher FROM books WHERE topic = 'Java' AND publisher NOT IN (SELECT publisher FROM books WHERE topic='Perl')

(select distinct publisher from books where topic = "Java") except
(select distinct publisher from books where topic = "Perl");

-- 3E) 
SELECT title FROM books WHERE publisher IN (SELECT publisher FROM books WHERE topic IN ('Java', 'Perl') GROUP BY publisher HAVING COUNT(DISTINCT topic) = 2) ORDER BY topic;

-- 3F) 
SELECT title, topic FROM books WHERE publisher IN (SELECT DISTINCT publisher FROM books WHERE topic = 'Java' AND publisher NOT IN (SELECT publisher FROM books WHERE topic='Perl')) ORDER BY topic;

-- 3G) 
SELECT title, topic FROM books WHERE topic='XML' AND title NOT LIKE '%XML%';