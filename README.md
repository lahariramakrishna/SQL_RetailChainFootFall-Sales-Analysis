# 🏬 Mini SQL Project: Retail Chain Footfall & Sales Analysis

## 📘 Project Overview

This project simulates customer visits and sales in a multi-store retail chain. It helps analyze how different locations perform, what customers are buying, and how long they spend in stores. You’ll use real-world SQL techniques to extract actionable insights from transactional data.

---

## 🎯 Objectives

- ✅ Create a **normalized SQL schema** with `Stores`, `Customers`, and `RetailFootfall` data  
- ✅ Clean and validate data using **SQL constraints and queries**  
- ✅ Perform data analysis using:
  - `JOIN`, `GROUP BY`, `HAVING`
  - String & Date/Time functions
  - `CASE` statements for categorization
  - **Subqueries** and **Window Functions**
- ✅ Prepare insights for **dashboards or reporting tools**

---

## ⚙️ Project Setup

### 1. 🧱 Database Schema

```sql
-- Stores Table
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    location VARCHAR(100)
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

-- Footfall Transactions Table
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
```

---

### 2. 🧹 Data Exploration & Cleaning

```sql
-- Find NULLs in sales
SELECT * FROM RetailFootfall WHERE total_amount_spent IS NULL;

-- Detect unusually long visits
SELECT * FROM RetailFootfall WHERE duration_in_store > 300;

-- Check for orphan customer records
SELECT * FROM RetailFootfall
WHERE customer_id NOT IN (SELECT customer_id FROM Customers);

-- Detect duplicate entries
SELECT entry_id, COUNT(*) 
FROM RetailFootfall 
GROUP BY entry_id HAVING COUNT(*) > 1;
```

---

### 3. 📊 Data Analysis & SQL Functions

#### ✅ 1. JOIN + Aggregation
```sql
SELECT s.location, SUM(r.total_amount_spent) AS total_revenue
FROM RetailFootfall r
JOIN Stores s ON r.store_id = s.store_id
GROUP BY s.location;
```

#### ✅ 2. String Functions
```sql
SELECT UPPER(name) AS customer_name, LENGTH(name) AS name_length
FROM Customers;
```

#### ✅ 3. Date & Time Functions
```sql
SELECT entry_date, DAYNAME(entry_date) AS day, HOUR(entry_time) AS hour
FROM RetailFootfall;
```

#### ✅ 4. CASE Statement (Age Grouping)
```sql
SELECT name, age,
  CASE 
    WHEN age < 25 THEN 'Young'
    WHEN age BETWEEN 25 AND 40 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group
FROM Customers;
```

#### ✅ 5. Subquery (Top Spending Customer)
```sql
SELECT * FROM Customers
WHERE customer_id = (
    SELECT customer_id
    FROM RetailFootfall
    GROUP BY customer_id
    ORDER BY SUM(total_amount_spent) DESC
    LIMIT 1
);
```

#### ✅ 6. DISTINCT, ORDER BY, LIMIT
```sql
SELECT DISTINCT category 
FROM RetailFootfall 
ORDER BY category 
LIMIT 5;
```

#### ✅ 7. GROUP BY + HAVING
```sql
SELECT category, COUNT(*) AS purchases
FROM RetailFootfall
GROUP BY category
HAVING COUNT(*) > 1;
```



## 📌 Findings

- 🏬 **Top Performing Store**: Store in *New Roberttown* had the highest total revenue.
- 🛒 **Popular Categories**: Most transactions occurred in the *Groceries*, *Books*, and *Beauty* categories.
- 👥 **Customer Age Group**: Majority of customers fall into the *Adult (25–40)* age group.
- 🚻 **Gender Behavior**:
  - *Females* tend to spend more on average.
  - *Males* spend more time in stores.
- ⏰ **Peak Visit Hours**: Most visits occurred between *12 PM – 3 PM*.
- ⚠️ **High Duration Alerts**: Some visits lasted over 300 minutes — potential anomalies or data entry issues.

---

## 🧾 Report Summary

This dataset captures footfall and sales data across multiple retail locations. By integrating customer demographics, store data, and transaction details, we performed detailed SQL analysis using joins, subqueries, string/date functions, and aggregation. The goal was to uncover patterns in customer behavior and store performance.

---

## ✅ Conclusion

The analysis provides actionable insights into retail performance and customer engagement. Key outcomes include identifying top revenue-generating stores, high-performing product categories, and behavior patterns by age and gender. These insights can guide targeted marketing, staffing decisions, and product placement strategies.

---


---
