﻿-- Script generated by Redgate Compare v1.23.0.23871


-- deployment: Dropping products.Date...
ALTER TABLE products DROP COLUMN Date;

select * from products;
