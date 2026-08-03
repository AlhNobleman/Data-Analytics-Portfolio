# Customer Segmentation using RFM Analysis

An end-to-end analytics project: cleaned a messy retail dataset in Excel, ran exploratory analysis and built RFM logic in SQL, and visualized customer segments in Tableau.

**🔗 Live Dashboard I**
**[View Interactive Dashboard →](https://public.tableau.com/views/RFMDASHBOARDI/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**


![Dashboard Preview](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/RFM-CUSTOMER-SEGMENTATION/GALLERY/RFM-Dashboard%20I.png)


**🔗 Live Dashboard II**
**[View Interactive Dashboard →](https://public.tableau.com/views/RFMDASHBOARDII/Dashboard2?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**


![Dashboard Preview](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/RFM-CUSTOMER-SEGMENTATION/GALLERY/RFM-Dashboard%20II.png)

---

## What this project does

Segments 350 customers into behavioral groups (**Champions, At Risk, Lost, New/Occasional**) using **Recency and Frequency** value, then visualizes revenue and customer distribution across those segments — the kind of analysis a retail business would use to prioritize retention efforts and marketing spend.

## Tools
Excel · MySQL · Tableau Public

## Key insights
- One of the dataset's most *frequent* buyers (88 orders) ranked outside the top 100 customers by total *spend* — a reminder that frequency and value don't always move together, and a big part of why this project scores customers on all three RFM dimensions rather than just one.
- According to my analysis, top-selling products by revenue and top-selling products by quantity frequently don't correspond — the product driving the most revenue isn't necessarily the one selling in the highest volume, and vice versa. This highlights the importance of evaluating product performance through multiple lenses rather than relying on a single metric.


## Dashboards

**Dashboard I — Executive Summary:** KPIs, revenue by segment, customer count by segment, RFM scatter plot, revenue by country.

**Dashboard II — Supporting Detail:** top products by revenue vs. quantity, RFM distribution histograms, average R/F/M per segment, top customers by spend.

## Skills demonstrated
Excel formula-based data recovery (lookup formulas, text parsing, conditional logic) · SQL (CTEs, window functions, aggregates) · RFM segmentation methodology · Tableau dashboard design

## Files
- [`dirty_retail_transactions.xlsx`](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/RFM-CUSTOMER-SEGMENTATION/dirty_retail_transactions.xlsx) — raw dataset
- [`Clean-retail-transactions.xlsx`](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/RFM-CUSTOMER-SEGMENTATION/clean-retail-transactions.xlsx) — cleaned data
- [`SQL-RFM_Analysis-Explanatory.sql`](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/RFM-CUSTOMER-SEGMENTATION/SQL-RFM_Analysis-Explanatory.sql) — SQL scripts
- [`Interactive-Dashboard-RFM.twbx`](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/RFM-CUSTOMER-SEGMENTATION/Interactive-Dashboard-RFM.twb) — Tableau workbook
- [Gallery](https://github.com/AlhNobleman/Data-Analytics-Portfolio/tree/main/RFM-CUSTOMER-SEGMENTATION/GALLERY) -- Images/Screenshots
- Read full write-up of the cleaning process, data issues encountered, and methodology decisions below

---

<details>
<summary><b>📋 Full process write-up (data issues, cleaning steps, methodology notes)</b></summary>

### Dataset issues at the start
- 511 rows missing CustomerID/CustomerName
- 956 rows missing Email
- Inconsistent InvoiceDate formats (mixed mm/dd/yyyy and dd/mm/yyyy)
- Duplicate rows not caught by an initial dedup pass
- Inconsistent UnitPrice formatting ($ symbols, comma decimals, zeros)
- Inconsistent Country spelling/casing

### Cleaning approach
- Recovered missing CustomerID/Name by extracting the ID embedded in each customer's email address
- Recovered missing emails via cross-referencing CustomerID across a customer's other rows
- Resolved date ambiguity by discovering and verifying a real pattern in the data: rows with a time component were consistently dd/mm/yyyy, rows without were mm/dd/yyyy
- Standardized prices using a StockCode-based lookup to backfill missing/zeroed values with each product's most common price
- Fixed a duplicate-detection bug where a sequential RowID column was making every row look unique to Excel's Remove Duplicates tool

**Known limitation:** negative quantities and "C"-prefixed invoice numbers (which represent returns/cancellations) were normalized early in cleaning, before their meaning was understood. This analysis therefore treats all transactions as completed sales; returns analysis was not performed on this dataset.

### RFM methodology
For each customer:

- Recency: days since their last purchase, relative to the dataset's most recent transaction date (not the real-world current date, since the dataset doesn't extend to today)
- Frequency: count of distinct invoices
- Monetary: total net spend (SUM(Quantity × UnitPrice)), reported per segment as a supporting metric

  Customers were segmented using a simple, direct Recency/Frequency threshold rule rather than a quartile-based scoring system, to keep the logic easy to read and explain:
  IF [Recency] <= 30 AND [Frequency] >= 15 THEN "Champions"
ELSEIF [Recency] <= 30 AND [Frequency] < 15 THEN "New/Occasional"
ELSEIF [Recency] > 30 AND [Frequency] >= 15 THEN "At Risk"
ELSE "Lost"
END

Because this rule uses exactly two binary conditions (Recency ≤/> 30, Frequency ≥/< 15), there are only 2² = 4 possible outcomes, all of which are explicitly covered, so no customer falls through to "Lost" by default due to incomplete logic.

Result: 350 customers split into Champions (141), At Risk (104), Lost (58), New/Occasional (47).
</details>
