﻿-- Script generated by Redgate Compare v1.23.0.23871


-- deployment: Dropping GetCustomerOrders...
DROP PROCEDURE GetCustomerOrders;


-- deployment: Creating orders.Date...
ALTER TABLE orders ADD COLUMN Date int(11) NULL;


-- deployment: Creating employees.LastModBy...
ALTER TABLE employees ADD COLUMN LastModBy date NULL;

