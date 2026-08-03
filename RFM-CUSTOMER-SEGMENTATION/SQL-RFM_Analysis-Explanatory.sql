SELECT * FROM rfm_analysis.company_sales;

-- 1.  Transaction-level exploration
# Total number of unique invoices
SELECT COUNT(DISTINCT InvoieNo)
FROM company_sales;

# Total number of unique customers
SELECT COUNT(DISTINCT CustomerID)
FROM company_sales;

# Total number of unique products
SELECT COUNT(DISTINCT `Description`)
FROM company_sales;

# Date range of the dataset (earliest to latest invoice)
SELECT *
FROM company_sales;
SELECT MIN(InvoiceDate) AS EarliestDay, MAX(InvoiceDate) AS LatestDay
FROM company_sales;

#  Total revenue overall
SELECT ROUND(SUM(Total), 0)
FROM company_sales;

# Average order value

SELECT ROUND(SUM(Total) / COUNT(DISTINCT InvoieNo), 0) AS Avg_order_value
FROM company_sales;

# Revenue by country
SELECT Country, ROUND(SUM(Total), 0) AS Revenue_by_country
FROM company_sales
GROUP BY country
ORDER BY Revenue_by_country DESC
LIMIT 3;

# Revenue by product
SELECT `Description`, ROUND(SUM(Total), 0) AS Revenue_by_product
FROM company_sales
GROUP BY `Description`
ORDER BY Revenue_by_product DESC
LIMIT 3;

# What product Nigerians buy the most
SELECT `Description`, COUNT(*) AS Total_purchase
FROM company_sales
WHERE country = 'Nigeria'
GROUP BY `Description`
ORDER BY Total_purchase DESC
LIMIT 1;

# Top 10 customers by total spend and country they are

SELECT customerID, CustomerName, Country, ROUND(SUM(Total), 0) AS Total_Spend, COUNT(InvoieNo)
FROM company_sales
GROUP BY CustomerID, CustomerName, Country
ORDER BY Total_Spend DESC
LIMIT 10;

# Top 10 best-selling products by quantity
SELECT *
FROM company_sales;

SELECT `Description` AS Best_Selling_Product, COALESCE(SUM(Quantity), 0) AS Quantity_sold
FROM company_sales
GROUP BY `Description`
ORDER BY  Quantity_sold DESC
LIMIT 10;

-- 4. Outlier and anomaly detection
SELECT * 
FROM company_sales
ORDER BY Quantity DESC
LIMIT 20;

SELECT * 
FROM company_sales
ORDER BY Total DESC
LIMIT 20;

-- 5. Customer purchase behavior 
# Distribution of number of orders per customer (are most customers one-time buyers, or repeat?)
SELECT CustomerID, CustomerName, COUNT(InvoieNO) AS Purchase_times
FROM company_sales
GROUP BY CustomerID, CustomerName
ORDER BY Purchase_times;

# Distribution of days between a customer's first and last purchase
SELECT CustomerID, CustomerName, COUNT(InvoieNO) AS Purchase_times, MIN(InvoiceDate) AS First_Purchase, MAX(InvoiceDate) AS Last_Purchase,
DATEDIFF(MAX(InvoiceDate), MIN(InvoiceDate)) AS Days_Between
FROM company_sales
GROUP BY CustomerID, CustomerName
ORDER BY First_Purchase, Days_Between desc;

# How many customers have only 1 transaction
SELECT CustomerID, CustomerName, COUNT(InvoieNO) AS Purchase_times
FROM company_sales
GROUP BY CustomerID, CustomerName
HAVING  Purchase_times = 1
ORDER BY Purchase_times;

-- 6. Build the actual RFM components
# Recency: days since each customer's most recent purchase (relative to your dataset's max date, not today's real date)

SELECT MAX(InvoiceDate)
FROM company_sales;


SELECT CustomerID, CustomerName, MAX(InvoiceDate) AS Last_purchase,
	DATEDIFF((SELECT MAX(InvoiceDate) FROM company_sales), MAX(InvoiceDate)) AS Recency
FROM company_sales
GROUP BY CustomerID, CustomerName
ORDER BY Recency;

# Frequency: count of distinct invoices per customer
SELECT CustomerID, CustomerName, COUNT(DISTINCT InvoieNO) AS Purchase_Frequency
FROM company_sales
GROUP BY CustomerID, CustomerName;

# Monetary: total spend per customer
SELECT CustomerID, CustomerName, ROUND(COALESCE(SUM(Total), 0), 0) AS Total_Spent
FROM company_sales
GROUP BY CustomerID, CustomerName
ORDER BY Total_Spent DESC;

# combining RFM
SELECT 
    cs.CustomerID,
    cs.CustomerName,
    MAX(cs.InvoiceDate) AS Last_Purchase_Date,
    DATEDIFF((SELECT MAX(InvoiceDate) FROM company_sales), MAX(cs.InvoiceDate)) AS Recency,
    COUNT(DISTINCT cs.InvoieNo) AS Frequency,
    ROUND(COALESCE(SUM(cs.Total), 0), 0) AS Monetary
FROM company_sales cs
GROUP BY cs.CustomerID, cs.CustomerName;

#--------------------------------------------------------------------
# # Frequency: count of distinct invoices per customer where Purchase_Frequency >= 70
SELECT CustomerID, CustomerName, COUNT(DISTINCT InvoieNO) AS Purchase_Frequency
FROM company_sales
GROUP BY CustomerID, CustomerName
HAVING Purchase_Frequency >= 70;


SELECT CustomerID, CustomerName, COUNT(DISTINCT InvoieNo) AS Frequency, 
       ROUND(COALESCE(SUM(Total), 0), 0) AS Monetary,
       DATEDIFF((SELECT MAX(InvoiceDate) FROM company_sales), MAX(InvoiceDate)) AS Recency
FROM company_sales
WHERE CustomerID = 12246
GROUP BY CustomerID, CustomerName;

SELECT InvoiceDate, Quantity, PriceUnit, Total
FROM company_sales
WHERE CustomerID = 12246
ORDER BY InvoiceDate;

SELECT AVG(total)
FROM company_sales;

