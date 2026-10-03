
SELECT *
FROM decisionmart_inventory;


-- check for duplicate

SELECT Order_ID, `Order Date`, `Product ID`, `Product Name`, `Category`, Subcategory, Brand, `Branch ID`, `Branch Name`, State,
Region, `Customer Type`, `Payment Method`, Quantity, `Unit Cost`, `Unit Price`, `Discount %`, Supplier, `Delivery Days`,
`Gross Sales`, `Discount Amount`, `Net Revenue`, `Total Cost`, Profit, `Profit Margin`, `Inventory Status`, COUNT(*) AS find_dup
FROM decisionmart_inventory
GROUP BY Order_ID, `Order Date`, `Product ID`, `Product Name`, `Category`, Subcategory, Brand, `Branch ID`, `Branch Name`, State,
Region, `Customer Type`, `Payment Method`, Quantity, `Unit Cost`, `Unit Price`, `Discount %`, Supplier, `Delivery Days`,
`Gross Sales`, `Discount Amount`, `Net Revenue`, `Total Cost`, Profit, `Profit Margin`, `Inventory Status`
HAVING find_dup >1;

# another way
WITH find_dup AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY Order_ID, `Order Date`, `Product ID`, `Product Name`, `Category`, Subcategory, Brand, `Branch ID`, `Branch Name`, State,
Region, `Customer Type`, `Payment Method`, Quantity, `Unit Cost`, `Unit Price`, `Discount %`, Supplier, `Delivery Days`,
`Gross Sales`, `Discount Amount`, `Net Revenue`, `Total Cost`, Profit, `Profit Margin`, `Inventory Status`) AS dup
FROM decisionmart_inventory
) 
SELECT *
FROM find_dup
WHERE dup > 1;

# create a new table
CREATE TABLE IF NOT EXISTS `decisionmart_inventory1` (
  `Order_ID` text,
  `Order Date` text,
  `Product ID` text,
  `Product Name` text,
  `Category` text,
  `Subcategory` text,
  `Brand` text,
  `Branch ID` text,
  `Branch Name` text,
  `State` text,
  `Region` text,
  `Customer Type` text,
  `Payment Method` text,
  `Quantity` int DEFAULT NULL,
  `Unit Cost` text,
  `Unit Price` text,
  `Discount %` text,
  `Supplier` text,
  `Delivery Days` int DEFAULT NULL,
  `Gross Sales` text,
  `Discount Amount` text,
  `Net Revenue` text,
  `Total Cost` text,
  `Profit` text,
  `Profit Margin` text,
  `Inventory Status` text,
  `find_dup` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# insert into table
INSERT INTO decisionmart_inventory1
SELECT Order_ID, `Order Date`, `Product ID`, `Product Name`, `Category`, Subcategory, Brand, `Branch ID`, `Branch Name`, State,
Region, `Customer Type`, `Payment Method`, Quantity, `Unit Cost`, `Unit Price`, `Discount %`, Supplier, `Delivery Days`,
`Gross Sales`, `Discount Amount`, `Net Revenue`, `Total Cost`, Profit, `Profit Margin`, `Inventory Status`, COUNT(*) AS find_dup
FROM decisionmart_inventory
GROUP BY Order_ID, `Order Date`, `Product ID`, `Product Name`, `Category`, Subcategory, Brand, `Branch ID`, `Branch Name`, State,
Region, `Customer Type`, `Payment Method`, Quantity, `Unit Cost`, `Unit Price`, `Discount %`, Supplier, `Delivery Days`,
`Gross Sales`, `Discount Amount`, `Net Revenue`, `Total Cost`, Profit, `Profit Margin`, `Inventory Status`;

# delete count
DELETE
FROM decisionmart_inventory1
WHERE find_dup = 2;

-- # drop column `find_dup`
ALTER TABLE `decisionmart_inventory1`
DROP COLUMN find_dup;



#--------------------------------------------------------------------------------------------------------------------
# Explonatory Data Analysis
SELECT *
FROM decisionmart_inventory1;

SELECT COUNT(Order_ID) AS total_sales_record, COUNT(DISTINCT Order_ID) AS `unique orders`, COUNT(DISTINCT `product name`) AS `unique product`,
COUNT(DISTINCT `branch name`) AS `No of branch`, COUNT(DISTINCT `Customer Type`) AS `No Customer Type`, COUNT(DISTINCT `Category`) AS `No of Category`,
COUNT(DISTINCT Supplier) AS `No of Supplier`, MIN(clean_date) AS `earliest Date`, MAX(clean_date) AS Latest_Date
FROM decisionmart_inventory1;


# Add new column "clean_date"
ALTER TABLE decisionmart_inventory1
ADD COLUMN
clean_date DATE;
UPDATE decisionmart_inventory1
SET clean_date = STR_TO_DATE(`Order date`, "%e-%b-%y");

#  Are there any duplicate Order IDs?
SELECT Order_ID, COUNT(Order_ID) AS dup
FROM decisionmart_inventory1
GROUP BY Order_ID
HAVING dup > 1;

# Are there any transactions containing suspicious financial or operational values that could distort our analysis?

SELECT
SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS negative_Q,
SUM(CASE WHEN `Unit Cost` < 0 THEN 1 ELSE 0 END) AS negatve_uc,
SUM(CASE WHEN `Unit Price` < 0 THEN 1 ELSE 0 END) AS  negative_up,
SUM(CASE WHEN `Discount %` < 0 THEN 1 ELSE 0 END) AS negetive_D,
SUM(CASE WHEN `Net Revenue` < 0 THEN 1 ELSE 0 END) AS negative_rev,
SUM( CASE WHEN Profit < 0 THEN 1 ELSE 0 END) AS negative_p,
SUM(CASE WHEN `Delivery Days` < 0 THEN 1 ELSE 0 END) AS negative_De,
SUM(CASE WHEN `Unit Cost` > `Unit Price` THEN 1 ELSE 0 END) AS ucVSup
FROM decisionmart_inventory1;

# Why are 228 transactions being sold below unit cost, and what characteristics do these transactions have?

SELECT Order_ID, `Product ID`, `Category`, Quantity, `Unit Cost`, `Unit Price`, `Discount %`, `Discount Amount`, `Net Revenue`, Profit
FROM decisionmart_inventory1
WHERE `Unit Cost` > `Unit Price`;

# check data type
DESCRIBE decisionmart_inventory1;

# update tabe
UPDATE decisionmart_inventory1
SET
    `Unit Cost` = REPLACE(`Unit Cost`, ',', ''),
    `Unit Price` = REPLACE(`Unit Price`, ',', ''),
    `Discount Amount` = REPLACE(`Discount Amount`, ',', ''),
    `Net Revenue` = REPLACE(`Net Revenue`, ',', ''),
    Profit = REPLACE(Profit, ',', ''),
    `Discount %` = REPLACE(`Discount %`, '%', '');
    
# change data type
ALTER TABLE decisionmart_inventory1
MODIFY Quantity INT,
MODIFY `Unit Cost` DECIMAL(15,2),
MODIFY `Unit Price` DECIMAL(15,2),
MODIFY `Discount %` DECIMAL(10,2),
MODIFY `Discount Amount` DECIMAL(15,2),
MODIFY `Net Revenue` DECIMAL(15,2),
MODIFY Profit DECIMAL(15,2),
MODIFY `Delivery Days` INT;

# check data type
DESCRIBE decisionmart_inventory1;

# -------------------------------------------------------------------------------------------------------------------
# Are there any transactions containing suspicious financial or operational values that could distort our analysis?

SELECT
SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS negative_Q,
SUM(CASE WHEN `Unit Cost` < 0 THEN 1 ELSE 0 END) AS negatve_uc,
SUM(CASE WHEN `Unit Price` < 0 THEN 1 ELSE 0 END) AS  negative_up,
SUM(CASE WHEN `Discount %` < 0 THEN 1 ELSE 0 END) AS negetive_D,
SUM(CASE WHEN `Net Revenue` < 0 THEN 1 ELSE 0 END) AS negative_rev,
SUM( CASE WHEN Profit < 0 THEN 1 ELSE 0 END) AS negative_p,
SUM(CASE WHEN `Delivery Days` < 0 THEN 1 ELSE 0 END) AS negative_De,
SUM(CASE WHEN `Unit Cost` > `Unit Price` THEN 1 ELSE 0 END) AS ucVSup
FROM decisionmart_inventory1;

# investigate the orders that are negative
SELECT Order_ID, `Product Name`, `Category`, Quantity, `Unit Cost`,
`Unit Price`, `Discount %`, `Discount Amount`, `Net Revenue`, Profit, `Branch Name`
FROM decisionmart_inventory1
WHERE Quantity < 0;

-- Which products have the highest number of returned transactions?
-- Which products have the highest number of returned units?
-- Which branch has the highest number of returned transactions?
-- Which category has the highest number of returned transactions?


-- Which products have the highest number of returned transactions?
SELECT `Product Name`,
SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS return_transaction
FROM decisionmart_inventory1
GROUP BY `Product Name`
ORDER BY return_transaction DESC
LIMIT 3;

-- Which products have the highest number of returned units?
WITH returned_units AS
(
SELECT `Product Name`, Quantity
FROM decisionmart_inventory1
WHERE Quantity < 0
)
SELECT `Product Name`, ABS(SUM(Quantity))
FROM returned_units
GROUP BY `Product Name`
ORDER BY SUM(Quantity)
LIMIT 3;

-- Which branch has the highest number of returned transactions?
WITH returned_branch AS
(
SELECT `Branch Name`, Quantity
FROM decisionmart_inventory1
WHERE Quantity < 0
)
SELECT `Branch Name`, COUNT(Quantity) AS count_of_returns_transactions
FROM returned_branch
GROUP BY `Branch Name`
ORDER BY COUNT(Quantity) DESC
LIMIT 3;


SELECT `Branch Name`,
SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS count_of_returns_transactions
FROM decisionmart_inventory1
GROUP BY `Branch Name`
ORDER BY count_of_returns_transactions DESC
LIMIT 3;

-- Which products have the highest number of returned transactions?
SELECT Category,
SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS returns_category
FROM decisionmart_inventory1
GROUP BY Category
ORDER BY  returns_category DESC
LIMIT 3;

# What is the total financial impact of these returns?
-- Total units returned, Total negative revenue, Total negative profit

SELECT ABS(SUM(Quantity)) AS Total_Unit_Returned, ABS(SUM(`Net Revenue`)) AS Total_Returned_Revenue, ABS(SUM(Profit)) AS Total_Returned_Profit
FROM decisionmart_inventory1
WHERE Quantity < 0;

# ------------------------------------------ NOTE------------------------------------------------------------------------------
-- DecisionMart recorded 53 return transactions, representing approximately 1.9% of the 2,799 orders analyzed. 
-- The returns amounted to 74 units, ₦305,847 in returned revenue, and approximately ₦70,157 in negative profit impact. 
-- AquaPure Water 75cl and Naija Malt Can had the highest number of return transactions at 6 each, 
-- while AquaPure recorded the highest returned quantity at 8 units. 
-- Ikeja City accounted for the highest number of returns with 20 transactions, 
-- while Beverages was the most affected category with 20 return transactions.


# Calculate these 8 KPIs in one query: Total Revenue, Total Profit, Overall Profit Margin, Total Transactions
# Total Units Sold, Average Order Value, Total Discount Amount, Total Cost

SELECT SUM(`Net Revenue`) AS Net_Revenue, SUM(Profit) AS Net_Profit, ((SUM(Profit)/SUM(`Net Revenue`)) * 100) AS profit_margin,
COUNT(Order_ID) AS Total_Transactions, SUM(Quantity) AS Net_units_Sold, (SUM(`Net Revenue`)/COUNT(Order_ID)) AS Average_Order_value,
SUM(`Discount Amount`) AS Total_Discount_Amount, SUM(`Total Cost`) AS Total_Cost
FROM decisionmart_inventory1;

#-------------------------------- NOTE-------------------------------------------------------------
# DecisionMart generated ₦39.32M in net revenue and ₦8.01M in profit across 2,799 transactions, 
# resulting in a 20.37% overall profit margin. The business sold 8,649 net units with an average order value of approximately ₦14,049. 
# Total discounts amounted to ₦3.24M, while total cost was ₦31.31M. 
# The revenue-cost relationship reconciles exactly to reported profit, validating the financial calculations.


# Monthly performance

SELECT monthname(clean_date) AS Month, SUM(`Net Revenue`) AS Net_Revenue, SUM(Profit) AS Net_Profit,
 (SUM(Profit)/ SUM(`Net Revenue`) * 100) AS Profit_Margin
FROM decisionmart_inventory1
GROUP BY MONTH(clean_date), MONTHNAME(clean_date)
ORDER BY MONTH(clean_date);

# is revenue growing
WITH current_month AS
(
SELECT MONTHNAME(clean_date) AS Months, SUM(`Net Revenue`) AS current_month_revenue
FROM decisionmart_inventory1
GROUP BY MONTHNAME(clean_date), MONTH(clean_date)
ORDER BY MONTH(clean_date)
)

SELECT Months, current_month_revenue, LAG(current_month_revenue) OVER(ORDER BY MONTH(Months)) AS previous_month_revenue,
((current_month_revenue - LAG(current_month_revenue) OVER(ORDER BY MONTH(Months)))/LAG(current_month_revenue) OVER(ORDER BY MONTH(Months)) * 100)
AS MoM_Change
FROM current_month;


# Which product categories are generating revenue, and how efficiently are they converting that revenue into profit?

SELECT *
FROM decisionmart_inventory.decisionmart_inventory1;

SELECT Category, SUM(`Net Revenue`) AS Total_Revenue, SUM(Profit) AS Total_Profit, ROUND((SUM(Profit) / SUM(`Net Revenue`) * 100), 1) AS Profit_Margin,
COUNT(Order_ID) AS Total_Transaction, SUM(Quantity) AS Total_Units_Sold
FROM decisionmart_inventory1
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- Within each category, which products are driving revenue

SELECT Category, `Product Name`, SUM(`Net Revenue`) AS Total_Revenue,
SUM(Profit) AS Total_Profit, ROUND((SUM(Profit) / SUM(`Net Revenue`) * 100), 1) AS Profit_Margin,
COUNT(Order_ID) AS Total_Transaction
FROM decisionmart_inventory1
GROUP BY Category, `Product Name`
ORDER BY Category, Total_Revenue DESC;

# For each product category, show me the 3 products generating the highest revenue
WITH rev_by_Product AS
(
SELECT Category, `Product Name`, SUM(`Net Revenue`) AS Total_Revenue,
SUM(Profit) AS Total_Profit, ROUND((SUM(Profit) / SUM(`Net Revenue`) * 100), 1) AS Profit_Margin,
COUNT(Order_ID) AS Total_Transaction
FROM decisionmart_inventory1
GROUP BY Category, `Product Name`
ORDER BY Category, Total_Revenue DESC
),

Top3_rev_by_Product AS
(
SELECT Category, `Product Name`, Total_Revenue, Total_Profit, Profit_Margin, Total_Transaction,
ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM rev_by_Product
)

SELECT Category, `Product Name`, Total_Revenue, Total_Profit, Profit_Margin, Total_Transaction, Revenue_Rank
FROM Top3_rev_by_Product
WHERE Revenue_Rank <=3;

-- How dependent is each category on its top-performing products
WITH product_revenue AS
(
SELECT Category, `Product Name`, SUM(`Net Revenue`) AS Product_Revenue
FROM decisionmart_inventory1
GROUP BY Category, `Product Name`
ORDER BY Category
),

Category_Total_Revenue AS 
(
SELECT Category, `Product Name`, Product_Revenue,
SUM(Product_Revenue) OVER(PARTITION BY Category) AS Category_Total_Revenue,
ROW_NUMBER() OVER(PARTITION BY Category ORDER BY product_revenue DESC) AS Revenue_Rank
FROM product_revenue
)

SELECT  Category,`Product Name`, Product_Revenue, Category_Total_Revenue,
((Product_Revenue/(Category_Total_Revenue)) * 100) AS Product_percent_of_Rev, Revenue_Rank
FROM Category_Total_Revenue;


SELECT *
FROM decisionmart_inventory1;
-- Which branches are generating revenue, and how does their profitability compare
SELECT 
	`Branch Name`, SUM(`Net Revenue`) AS Total_Revenue,
	SUM(Profit) AS Total_Profit, ROUND((SUM(Profit) / SUM(`Net Revenue`) * 100), 1) AS Profit_Margin,
	COUNT(Order_ID) AS Total_Transaction, SUM(Quantity) AS Net_unit_Sold,
    round((SUM(`Net Revenue`))/(COUNT(Order_ID)), 0) AS Average_Order_Value
FROM decisionmart_inventory1
GROUP BY `Branch Name`
ORDER BY Total_Revenue DESC;



