-- zad. 1
SELECT c.CustomerID, CustomerName, CustomerSurname, DateOfBirth, COALESCE(Email, '---') Email, o.OrderID, COALESCE(DATE(OrderTimestamp), '') OrderDate, COALESCE(DATE(DeliveryTimestamp), '') DeliveryDate FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY (o.OrderID IS NULL) DESC, CustomerSurname, CustomerName, DateOfBirth, CustomerID, OrderTimestamp;
 
 -- zad. 2
 SELECT o.OrderID, DATE(o.OrderTimestamp) OrderDate, oi.Quantity, p.ProductName, p.Price FROM Orders o
 JOIN OrderItems oi ON o.OrderID = oi.OrderID
 JOIN Products p ON oi.ProductID = p.ProductID
 ORDER BY o.OrderID, p.ProductName;
 
 -- zad. 3
 SELECT c.CustomerID, c.CustomerName, c.CustomerSurname, o.OrderID, DATE(o.OrderTimestamp) OrderDate, p.ProductID, p.ProductName, oi.Quantity FROM Customers c
 JOIN Orders o ON c.CustomerID = o.CustomerID
 JOIN OrderItems oi ON o.OrderID = oi.OrderID
 JOIN Products p ON oi.ProductID = p.ProductID
 WHERE oi.Quantity > 1
 ORDER BY c.CustomerSurname, c.CustomerName, c.CustomerID, o.OrderID, p.ProductName;
 
 -- zad. 4
 SELECT o.OrderID, 
 DATE(o.OrderTimestamp) OrderDate, 
 CONCAT('(', c.CustomerID, ') ', c.CustomerName, ' ', c.CustomerSurname, ' (', c.DateOfBirth, ') ') CustomerInfo,
 GROUP_CONCAT(CONCAT(p.ProductName, ' (', oi.Quantity, ' szt.)') ORDER BY p.ProductName SEPARATOR ', ' ) AS ProductsSummary, 
 GROUP_CONCAT(CONCAT(oi.Quantity, ' x ', p.Price) ORDER BY p.ProductName SEPARATOR ' + ' ) AS ValueDetails,
 SUM(oi.Quantity * p.Price) AS TotalAmount 
 FROM Customers c
 JOIN Orders o ON c.CustomerID = o.CustomerID
 JOIN OrderItems oi ON o.OrderID = oi.OrderID
 JOIN Products p ON oi.ProductID = p.ProductID
 GROUP BY o.OrderID
 ORDER BY o.OrderID;