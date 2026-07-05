# EXploratory

SELECT *
FROM retail_sales1;

# Reward customers
SELECT customer_id, sum(total_spent) AS total, "2 Free item: their favorite" AS incentive
FROM retail_sales1
GROUP BY customer_id
HAVING total >= 65000
UNION
SELECT customer_id, sum(total_spent) AS total, "1 Free item: their favorite" AS incentive
FROM retail_sales1
GROUP BY customer_id
HAVING total <= 64999
ORDER BY customer_id;
#--------------------------------------------------------------------

# make it a table
CREATE TABLE `comeback_bonus` 
(
  customer_id VARCHAR(10),
  total INT,
  incentive VARCHAR(50)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO comeback_bonus
SELECT customer_id, sum(total_spent) AS total, "2 Free item: their favorite" AS incentive
FROM retail_sales1
GROUP BY customer_id
HAVING total >= 65000
UNION
SELECT customer_id, sum(total_spent) AS total, "1 Free item: their favorite" AS incentive
FROM retail_sales1
GROUP BY customer_id
HAVING total <= 64999
ORDER BY customer_id;
#-------------------------------------------------------------------------------------------------

# Top 5 customers by average spend per transaction
SELECT *
FROM retail_sales1;

SELECT customer_id, AVG(total_spent) avg_spent
FROM retail_sales1
GROUP BY customer_id
ORDER BY avg_spent DESC
LIMIT 5;

# Which category has the highest average price per unit?  

SELECT category, AVG(price_per_unit)
FROM retail_sales1
GROUP BY category
ORDER BY AVG(price_per_unit) DESC;

# Find customers who made purchases in more than one location (Online + In-store)
SELECT customer_id, COUNT(DISTINCT location) num_locations
FROM retail_sales1
GROUP BY customer_id
HAVING COUNT( DISTINCT location) > 1
ORDER BY num_locations DESC;

# Monthly sales trend — Show total revenue (total_spent) by month across all years  
SELECT 
    DATE_FORMAT(date, '%Y-%m') AS `year_month`,
    SUM(total_spent) AS total_revenue
FROM retail_sales1
GROUP BY `year_month`
ORDER BY `year_month`;

# Which item was sold the most times (by quantity) in the "Patisserie" category?
SELECT item, SUM(quantity)
FROM retail_sales1
WHERE category = "Patisserie"
GROUP BY item
ORDER BY SUM(quantity) DESC
LIMIT 1;

# Top 3 most expensive single transactions (highest total_spent in one row)
SELECT transaction_id, customer_id, total_spent, payment_method,category, `date`
FROM retail_sales1
ORDER BY total_spent DESC
LIMIT 3;

# Customers who made purchases in all 3 years
SELECT customer_id, COUNT(DISTINCT YEAR(date)) AS num_years
FROM retail_sales1
GROUP BY customer_id
HAVING num_years >= 3
ORDER BY customer_id;

SELECT 
    YEAR(date) AS year,
    COUNT(*) AS transactions
FROM retail_sales1
GROUP BY YEAR(date)
ORDER BY year;

#--------------------
#Find which day of the week has the highest total sales revenue (total_spent).
#Also show the total revenue and number of transactions for each day of the week.

SELECT DAYNAME(date) AS num_days, SUM(total_spent) AS revenue, COUNT(*)
FROM retail_sales1
GROUP BY num_days
ORDER BY revenue DESC;


 




