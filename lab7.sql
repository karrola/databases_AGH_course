-- zad.5
select o.OrderID, 
	date(o.OrderTimestamp) OderDate, 
    coalesce(date(o.DeliveryTimestamp),'') DeliveryDate,
    case when o.DeliveryTimestamp is not NULL then 'Yes' else 'No' end Delivered,
    case when o.DeliveryTimestamp is not NULL then datediff(o.DeliveryTimestamp, o.OrderTimestamp) else '' end DaysToDeliver
from Orders o 
order by (o.DeliveryTimestamp is null) desc, DaysToDeliver, o.OrderTimestamp;

-- zad.6
select c.CustomerID, c.CustomerName, c.CustomerSurname, 
count(distinct(o.OrderID)) OrdersCount,
coalesce(sum((p.Price*oi.Quantity)), '0.00') TotalSpent
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
left join OrderItems oi on o.OrderID = oi.OrderID
left join Products p on oi.ProductID = p.ProductID
group by c.CustomerID
order by c.CustomerID;

-- zad.7
select o.OrderID, date(o.OrderTimestamp) OrderDate, date(o.DeliveryTimestamp) DeliveryDate,
case 
	when datediff(o.DeliveryTimestamp, o.OrderTimestamp) is NULL then 'Not delivered'
    when datediff(o.DeliveryTimestamp, o.OrderTimestamp) = 0 then 'Same day'
    when datediff(o.DeliveryTimestamp, o.OrderTimestamp) between 1 and 2 then 'Fast (1-2 days)'
    when datediff(o.DeliveryTimestamp, o.OrderTimestamp) between 3 and 5 then 'Normal (3-5 days)'
    else 'Slow (6+ days)'
end DeliveryClass
from Orders o
order by o.OrderID;

-- zad.8
select c.CustomerID, c.CustomerName, c.CustomerSurname, c.DateOfBirth,
timestampdiff(year, c.DateOfBirth, curdate()) Age,
case when timestampdiff(year, c.DateOfBirth, curdate()) >= 18 then 'DOROSŁY' else 'NIEPEŁNOLETNI' end Status
from Customers c
order by c.CustomerID;

-- zad.9
with Expenses as (
    select c.CustomerID, c.CustomerName, c.CustomerSurname, sum((p.Price*oi.Quantity)) TotalSpent
    from Customers c
    left join Orders o on c.CustomerID = o.CustomerID
    left join OrderItems oi on o.OrderID = oi.OrderID
    left join Products p on oi.ProductID = p.ProductID
    group by c.CustomerID
    )
select *
from Expenses 
where TotalSpent > 2000
order by TotalSpent desc;

-- zad.10
select coalesce(c.CategoryName, 'Brak kategorii'),
sum(oi.Quantity) UnitsSold,
sum(oi.Quantity*p.Price) TotalSales
from OrderItems oi 
join Products p on oi.ProductID = p.ProductID
left join Categories c on p.CategoryID = c.CategoryID
group by c.CategoryName
order by TotalSales desc;

-- zad.11
select p.ProductID, p.ProductName, p.Price, coalesce(c.CategoryName, 'Brak kategorii') CategoryName
from Products p
left join Categories c on p.CategoryID = c.CategoryID
order by p.ProductID;

-- zad.12
select c.CustomerID, c.CustomerName, c.CustomerSurname, char_length(c.CustomerSurname) SurnameLength
from Customers c
where c.CustomerSurname like '%-%'
order by c.CustomerID;

-- zad.13
select o.OrderID, date(o.OrderTimestamp) OrderDate, datediff(curdate(), date(o.OrderTimestamp)) DaysSinceOrder
from Orders o
where o.DeliveryTimestamp is NULL;

-- zad.14
select group_concat(concat(p.ProductName) order by p.ProductName separator ', ')
from Products p;