-- Window Functions:
-- 1. Example: Calculate the total sales amount for each order along with the individual product sales.
SELECT 
    o.Order_ID,
    p.Product_ID,
    p.Product_Name,
    p.Price,
    o.Quantity,
    o.Total_Price,
    SUM(p.Price * o.Quantity) OVER (PARTITION BY o.Order_ID) AS total_sales_amount
FROM 
    yanki.orders o
JOIN 
    yanki.products p ON o.Product_ID = p.Product_ID;
	
-- 2. Example: Calculate the running total price for each order.
SELECT 
    Order_ID,
    Product_ID,
    Quantity,
    Total_Price,
    SUM(Total_Price) OVER (ORDER BY Order_ID) AS running_total_price
FROM 
    yanki.orders;

-- 3. Example: Rank products by their price within each category.
SELECT 
    Product_ID,
    Product_Name,
    Brand,
    Category,
    Price,
    RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS price_rank
FROM 
    yanki.products;
	

-- Ranking:
-- 1. Example: Rank customers by the total amount they have spent.
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Total_Price) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.Total_Price) DESC) AS customer_rank
FROM 
    yanki.customers c
JOIN 
    yanki.orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID,
    c.Customer_Name;


-- 2. Example: Rank products by their total sales amount.
SELECT 
    p.Product_ID,
    p.Product_Name,
    SUM(o.Quantity) AS total_quantity_sold,
    RANK() OVER (ORDER BY SUM(o.Quantity) DESC) AS product_rank
FROM 
    yanki.products p
JOIN 
    yanki.orders o ON p.Product_ID = o.Product_ID
GROUP BY 
    p.Product_ID,
    p.Product_Name;


-- 3. Example: Rank orders by their total price.
SELECT 
    Order_ID,
    Total_Price,
    RANK() OVER (ORDER BY Total_Price DESC) AS order_rank
FROM 
    yanki.orders;
	
	
-- Case:
-- 1. Example: Categorize the orders based on the total price.
SELECT 
    Order_ID,
    Total_Price,
    CASE 
        WHEN Total_Price >= 1000 THEN 'High'
        WHEN Total_Price >= 500 AND Total_Price < 1000 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM 
    yanki.orders;


-- 2. Example: Classify customers by the number of orders they made.
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS num_orders,
    CASE 
        WHEN COUNT(o.Order_ID) >= 10 THEN 'Frequent'
        WHEN COUNT(o.Order_ID) >= 5 AND COUNT(o.Order_ID) < 10 THEN 'Regular'
        ELSE 'Occasional'
    END AS order_frequency
FROM 
    yanki.customers c
JOIN 
    yanki.orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID,
    c.Customer_Name;


-- 3. Example: Classify products by their prices.
SELECT 
    Product_ID,
    Product_Name,
    Price,
    CASE 
        WHEN Price >= 500 THEN 'Expensive'
        WHEN Price >= 100 AND Price < 500 THEN 'Moderate'
        ELSE 'Affordable'
    END AS price_category
FROM 
    yanki.products;


-- Joins
-- Inner Joins
-- 1. Example: Retrieve customer details along with the products they ordered.
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    c.Email,
    c.Phone_Number,
    o.Order_ID,
    p.Product_ID,
    p.Product_Name,
    p.Price,
    o.Quantity,
    o.Total_Price
FROM 
    yanki.customers c
INNER JOIN 
    yanki.orders o ON c.Customer_ID = o.Customer_ID
INNER JOIN 
    yanki.products p ON o.Product_ID = p.Product_ID;

-- 2. Example: Retrieve order details along with payment information.
SELECT 
    o.Order_ID,
    pm.Payment_Method,
    pm.Transaction_Status
FROM 
    yanki.orders o
INNER JOIN 
    yanki.payment_method pm ON o.Order_ID = pm.Order_ID;


-- Left Join
-- 1. Example: Retrieve all customers along with their orders, even if they haven't placed any orders.
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    c.Email,
    c.Phone_Number,
    o.Order_ID,
    o.Product_ID,
    o.Quantity,
    o.Total_Price
FROM 
    yanki.customers c
LEFT JOIN 
    yanki.orders o ON c.Customer_ID = o.Customer_ID;

-- 2. Example: Retrieve all orders along with product details, even if there are no corresponding products.
SELECT 
    o.Order_ID,
    o.Customer_ID,
    p.Product_ID,
    p.Product_Name,
    p.Price,
    o.Quantity,
    o.Total_Price
FROM 
    yanki.orders o
LEFT JOIN 
    yanki.products p ON o.Product_ID = p.Product_ID;


-- Right Join:
-- 1. Example: Retrieve all orders along with payment information, even if there are no corresponding payment records.
SELECT 
    o.Order_ID,
    pm.Payment_Method,
    pm.Transaction_Status
FROM 
    yanki.orders o
RIGHT JOIN 
    yanki.payment_method pm ON o.Order_ID = pm.Order_ID;
	
	
-- 2. Example: Retrieve all products along with the orders, even if there are no corresponding orders.
SELECT 
    p.Product_ID,
    p.Product_Name,
    o.Order_ID,
    o.Quantity,
    o.Total_Price
FROM 
    yanki.products p
RIGHT JOIN 
    yanki.orders o ON p.Product_ID = o.Product_ID;

-- Outer Join:
-- 1. Example: Retrieve all customers along with their orders, including customers who have not placed any orders, and orders without corresponding customers.
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    c.Email,
    c.Phone_Number,
    o.Order_ID,
    o.Product_ID,
    o.Quantity,
    o.Total_Price
FROM 
    yanki.customers c
FULL OUTER JOIN 
    yanki.orders o ON c.Customer_ID = o.Customer_ID;


-- 2. Example: Retrieve all orders along with payment information, including orders without corresponding payment records and payment records without corresponding orders.
SELECT 
    o.Order_ID,
    pm.Payment_Method,
    pm.Transaction_Status
FROM 
    yanki.orders o
FULL OUTER JOIN 
    yanki.payment_method pm ON o.Order_ID = pm.Order_ID;

