-- A. 
select avg(price) from books;

-- B. 
select * from books where price > (select avg(price) from books);

-- C. 
select distinct publisher, topic from books;

-- D. 
select distinct publisher, topic, count(*) as number from books group by publisher, topic

-- E. 
select distinct publisher, topic, count(*) as number from books group by publisher, topic order by publisher, topic;

-- F. 
select distinct publisher, topic, count(*) as number from books group by publisher, topic order by number desc, publisher, topic;

-- G. 
select min(price) as min, max(price) as max, avg(price) as avg from books;

-- H1. 
select topic, count(*) from books group by topic;

-- H2. 
select avg(number) as avg from (select count(*) as number from books group by topic) as sub

-- ważne: aliasy dla tabeli  i kolumny konieczne

-- I1. 
select publisher, count(*) from books group by publisher

-- I2. 
select avg(number) as avg from (select count(*) as number from books group by publisher) as sub

-- J. 
select publisher from books group by publisher having count(*) > 1;

-- K. 
select publisher from books group by publisher having count(*) > (select avg(number) from (select count(*) as number from books group by publisher) as sub);

-- L. 
select publisher from books group by publisher having count(distinct topic) >= 2;

-- M. 
select publisher from books where publisher not in (select publisher from books where topic = 'java') group by publisher having count(distinct topic) >= 2;

(select publisher from books group by publisher having count(distinct topic) ≥ 2) except (select distinct publisher from books where topic = ‘ java’);

-- N. 
select publisher from books where topic in ('java', 'perl') group by publisher having count(distinct topic) = 2;

-- O1. 
select publisher, count(*) as number from books where topic in ('java', 'perl') group by publisher having count(distinct topic) = 1;

-- O2. 
select publisher, count(*) as number from books where topic in ('java', 'perl') group by publisher having count(distinct topic) = 1 and number < 3;

-- P. 
select publisher, topic, avg(price) as avg, min(price) as min, max(price) as max from books group by publisher, topic;

-- P*. 
select publisher, topic, round(avg(price), 2) as avg, min(price) as min, max(price) as max from books group by publisher, topic;

-- Q1. 
select publisher, count(distinct topic), avg(price), min(price), max(price), max(price) - min(price) from books group by publisher;

-- Q3. 
select publisher, count(distinct topic) as 'topics', round(avg(price), 4) as 'avg', round(min(price),2) as 'min', round(max(price), 2) as 'max', round(max(price) - min(price), 2) as 'range' from books group by publisher;