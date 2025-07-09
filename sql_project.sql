-- Creation and Usage of DataBase
CREATE DATABASE sql_project;
USE sql_project;

-- For creating Tables
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    location VARCHAR(100)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE RetailFootfall (
    entry_id INT PRIMARY KEY,
    entry_date DATE,
    entry_time TIME,
    store_id INT,
    customer_id INT,
    items_bought INT,
    category VARCHAR(50),
    total_amount_spent DECIMAL(10,2),
    duration_in_store INT,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- To view the data present in tables
select * from Stores;
select * from Customers;
select * from RetailFootfall;


-- Find NULLs
SELECT * FROM RetailFootfall WHERE total_amount_spent IS NULL;

-- Long visits
SELECT * FROM RetailFootfall WHERE duration_in_store > 300;

-- Orphan records (invalid foreign keys)
SELECT * FROM RetailFootfall
WHERE customer_id NOT IN (SELECT customer_id FROM Customers);

-- Duplicates
SELECT entry_id, COUNT(*) 
FROM RetailFootfall 
GROUP BY entry_id HAVING COUNT(*) > 1;

-- Using Joins And Aggreagate Function
SELECT s.location, SUM(r.total_amount_spent) AS total_revenue
FROM RetailFootfall r
JOIN Stores s ON r.store_id = s.store_id
GROUP BY s.location;

-- To convert Name into UpperCase and Length
SELECT UPPER(name) AS customer_name, LENGTH(name) AS name_length
FROM Customers;


--  Date & Time Functions
SELECT entry_date, DAYNAME(entry_date) AS day, HOUR(entry_time) AS hour
FROM RetailFootfall;

-- If age<25.Display 'YOUNG' else if age is between 25 and 40.Display 'ADULT' or else 'SENIOR'
SELECT name, age,
  CASE 
    WHEN age < 25 THEN 'Young'
    WHEN age BETWEEN 25 AND 40 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group
FROM Customers;

-- Subquery (Top Spending Customer)
SELECT * FROM Customers
WHERE customer_id = (
    SELECT customer_id
    FROM RetailFootfall
    GROUP BY customer_id
    ORDER BY SUM(total_amount_spent) DESC
    LIMIT 1
);

-- Display the 5 records which has distinct category in order
SELECT DISTINCT category FROM RetailFootfall ORDER BY category LIMIT 5;


-- Write an SQL query to find all product categories from the RetailFootfall table that have been purchased more than once. The result should include the category name and the number of purchases for each.
SELECT category, COUNT(*) AS purchases
FROM RetailFootfall
GROUP BY category
HAVING COUNT(*) > 1;




