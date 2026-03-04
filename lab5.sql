--zad. 4
select year(born) as year, count(*) as number from User2 group by year;

--zad.6.1
select avg(age) from User2;

--zad.6.2
select avg(age) from User2 as u
join UserGoods as ug on u.user_id = ug.user_id
join Goods as g on ug.goods_id = g.goods_id
where product = 'satellite tuner';

--zad.6.3
select avg(number) as srednia_liczba from (
	select count(distinct g.product) as number from User2 as u
	join UserGoods as ug on u.user_id = ug.user_id
	join Goods as g on ug.goods_id = g.goods_id
	where born > '1976-01-01'
	group by u.user_id) as sub;