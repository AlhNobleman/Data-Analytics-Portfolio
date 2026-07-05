# Import the table to sql (I had to change the column case to lowercase for better view)

CREATE DATABASE retail_sales;
LOAD DATA LOCAL INFILE 'C:/Users/ACER/Downloads/Data Analysis Journey/retail_sales.csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;     -- Skip header row
#--------------------------------------------------------------------
CREATE TABLE retail_sales1
LIKE retail_sales;
--
INSERT INTO retail_sales1
SELECT *
FROM retail_sales;
#-------------------------------------------

#search for duplicate
SELECT transaction_id, customer_id, category, item, price_per_unit, quantity,
total_spent, payment_method, location, `date`, discount_applied, COUNT(*) AS count
FROM retail_sales1
GROUP BY transaction_id, customer_id, category, item, price_per_unit, quantity, total_spent, payment_method, location, date, discount_applied
HAVING count > 1;

# using window function
WITH check_dup AS
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY transaction_id, customer_id, category, item, price_per_unit,
quantity, total_spent, payment_method, location, date, discount_applied) AS row_num
FROM retail_sales
)
SELECT *
FROM check_dup
WHERE row_num > 1; # no duplocate

#------------------------------------------------------------------------------- 
# standardization 
SELECT *
FROM retail_sales1;

# To check for rows which has value for quantity and total_spent where price per unit is empty or 0
SELECT *
FROM retail_sales1
WHERE price_per_unit = 0 AND quantity !=0 AND total_spent != 0;
#--
# Update table: To get price per unit, I said total_spent / quantity = price_per_unit
UPDATE retail_sales1
SET price_per_unit = total_spent / quantity
WHERE price_per_unit = 0 AND quantity !=0 AND total_spent != 0;

#--------------------------------------------------------------------------

# Delete where quantity is 0 (backup: raw data)
DELETE 
FROM retail_sales1
WHERE quantity = 0;
#--------------------------------------------------------

# working on ITEM column, category "Patisserie" has 'Item_11_PAT' and price_per_unit = 20
# Fill the empty field in item with 'Item_11_PAT' 
SELECT category, item, price_per_unit, quantity, total_spent
FROM retail_sales1
WHERE category = "Patisserie" AND price_per_unit = 20; 

# Update table: Fill the empty field in item with 'Item_11_PAT'
UPDATE retail_sales1
SET item = 'Item_11_PAT'
WHERE item = "";

#confirmation
SELECT  category, item, price_per_unit, quantity, total_spent
FROM retail_sales1
WHERE category = "Patisserie" AND price_per_unit = 20;

SELECT category, item, price_per_unit, quantity, total_spent
FROM retail_sales1
WHERE category = "Patisserie";
#----

SELECT *
FROM retail_sales1;
#-------------------------------------------------------------------
# Drop discount_applied column
ALTER TABLE retail_sales1
DROP COLUMN discount_applied;

SELECT *
FROM retail_sales1;
#--------------------------------------------------------------

#date
# date
UPDATE retail_sales1
SET `date` = STR_TO_DATE(`date`, "%m/%d/%Y");

# change date text type to DATE type
ALTER TABLE retail_sales1
MODIFY `date` DATE;

#-------------------------------------------------------------------------------
SELECT *
FROM retail_sales1;




