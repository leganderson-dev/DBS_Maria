﻿-- Script generated by Redgate Compare v1.23.0.23871


-- deployment: Creating GetCustomerOrders...
CREATE PROCEDURE GetCustomerOrders (IN cust_id int(11))
BEGIN
    SELECT o.OrderID, o.OrderDate, o.Amount
    FROM Orders o
    WHERE o.CustomerID = cust_id;
END;


-- deployment: Dropping orders.Date...
ALTER TABLE orders DROP COLUMN Date;


-- deployment: Dropping employees.LastModBy...
ALTER TABLE employees DROP COLUMN LastModBy;
