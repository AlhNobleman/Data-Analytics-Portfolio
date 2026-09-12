# 📊 Sales Performance & Inventory Optimization Dashboard

## 📌 Project Overview

This project is an interactive **Sales Performance, Profitability & Inventory Optimization Dashboard** built in Microsoft Excel.

The objective of the project is to transform raw sales data into actionable business insights that can help management understand:

- Revenue and profit performance
- Monthly sales and profitability trends
- Branch-level performance
- Product contribution to total revenue
- Inventory health and stock imbalances
- High- and low-performing products
- Product opportunities based on revenue, margin, and inventory status

The dashboard was designed as a **management decision-support tool**, allowing users to interact with the data through slicers and explore different aspects of business performance.



## 🚀 How to Use

**1. Download the Excel dashboard**

Download:
`DecisionMart_Retail_Dashboard.xlsm`

**2. Unblock the file**

After downloading:

`Right-click → Properties → Unblock → Apply → OK`

**3. Open in Microsoft Excel**

When prompted:

`Security Warning → Enable Content`

**4. Interact with the dashboard**

Use the slicers and interactive controls to explore the data.

> ⚠️ This dashboard uses VBA macros for some interactive features.
> Macros must be enabled for those features to work.

---

## 🎯 Business Problem

Businesses can generate significant revenue while still experiencing problems such as:

- Poor profit margins
- Overstocked products
- Understocked high-performing products
- Poor-performing branches
- Excess capital tied up in inventory
- High dependence on a small number of products

The purpose of this project was to analyze these areas and provide management with a clear view of **where the business is performing well, where problems exist, and where opportunities should be prioritized.**

---

## 📈 Dashboard Preview

![Sales Dashboard](https://github.com/AlhNobleman/Data-Analytics-Portfolio/blob/main/DecisionMart_LTD%20_Inventory_Dashboard/screenshots/DecisionMart_dashboard.png)

> The dashboard contains interactive KPIs, charts, product analysis, inventory classification, and a Product Opportunity Matrix.

---

## 🔑 Key KPIs

The dashboard tracks the following major performance indicators:

| KPI | Value |
|---|---:|
| Net Revenue | ₦39.8M |
| Profit | ₦8.1M |
| Profit Margin | 20.3% |
| Total Transactions | 2,801 |
| Average Monthly Revenue | ₦3.3M |
| Average Monthly Profit | ₦674.3K |

*Values shown represent the dashboard snapshot used for this portfolio project.*

---

## 📊 Dashboard Components

### 1. Executive KPI Cards

The dashboard provides an executive-level overview of:

- Net Revenue
- Profit
- Profit Margin
- Total Transactions
- Comparison against previous periods
- Average revenue and profit

These KPIs allow management to quickly assess overall business performance.

---

### 2. Monthly Revenue, Profit & Margin Trend

A combination chart was created to analyze:

- Monthly revenue
- Monthly profit
- Monthly profit margin

This helps identify changes in business performance over time and periods of stronger or weaker performance.

---

### 3. Profitability by Branch

Branch performance is analyzed using:

- Revenue
- Profit Margin

This allows management to identify branches generating strong revenue and compare their profitability.

---

### 4. Top 5 Products by Revenue

The dashboard identifies the products contributing the largest share of total revenue.

The Top 5 products account for approximately **62.6% of total revenue** in the analyzed dataset.

This highlights the importance of understanding product concentration and the potential risk associated with depending heavily on a small number of products.

---

### 5. Top 5 Products by Profit Margin

The dashboard also identifies products with the strongest profit margins.

This helps management distinguish between:

- Products that generate high revenue
- Products that generate high margins
- Products that perform strongly in both areas

---

## 📦 Inventory Analysis

Inventory was classified into three categories:

### 🔴 Understocked
Products where inventory levels may not be sufficient to support demand.

### 🟠 Overstocked
Products where inventory levels are higher than necessary relative to their performance.

### 🟢 Healthy
Products with balanced inventory levels.

### Current Inventory Snapshot

| Inventory Status | Products |
|---|---:|
| Understocked | 9 |
| Overstocked | 10 |
| Healthy | 5 |

This reveals a significant inventory imbalance, with more products overstocked or understocked than maintained at healthy levels.

---

# 🎯 Product Opportunity Matrix

One of the major analytical features of this project is the **Product Opportunity Matrix**.

Products are classified using two key performance dimensions:

- Net Revenue
- Profit Margin

The classification is then combined with inventory status to identify actionable business opportunities.

### Product Classification Framework

| Revenue | Profit Margin | Classification |
|---|---|---|
| High | High | ⭐ Star |
| High | Low | 💰 Profit Opportunity |
| Low | High | 🚀 Growth Opportunity |
| Low | Low | 🔴 Low Priority |

This framework allows management to move beyond simply asking:

> "Which products are selling?"

and instead ask:

> "Which products should we prioritize?"

---

# 💡 Key Business Insights

### 1. Strong Overall Financial Performance

The business generated approximately **₦39.8M in revenue and ₦8.1M in profit**, resulting in an overall profit margin of approximately **20.3%**.

This indicates healthy overall profitability.

---

### 2. Revenue Concentration

The Top 5 products contribute approximately **62.6% of total revenue**.

This represents an important opportunity but also creates concentration risk.

A disruption affecting one or more of these major products could have a significant impact on overall revenue.

---

### 3. Inventory Imbalance

The analysis identified:

- 9 understocked products
- 10 overstocked products
- 5 healthy products

This suggests that inventory allocation is not fully aligned with product performance.

---

### 4. High-Revenue Products With Margin Pressure

Several major revenue-generating products are classified as:

**High Revenue + Low Margin**

These products generate substantial sales but provide an opportunity to improve profitability through:

- Supplier negotiation
- Pricing optimization
- Discount management
- Cost reduction
- Improved purchasing terms

---

### 5. High-Margin Growth Opportunities

Several products have:

**Low Revenue + High Margin**

These products may represent growth opportunities.

Rather than immediately reducing their prices, management can test:

- Cross-selling
- Product bundling
- Better product placement
- Targeted promotions
- Increased visibility

---

### 6. Low-Revenue, Low-Margin Overstocked Products

Products classified as:

**Low Revenue + Low Margin + Overstocked**

should receive lower purchasing priority.

Excess inventory in these products can tie up working capital and warehouse capacity.

---

# ⭐ Featured Product Opportunity

### SoundBeat Earbuds

SoundBeat Earbuds is classified as a:

**⭐ STAR PRODUCT**

because it combines:

- High Revenue
- High Profit Margin
- Understocked inventory

This makes it an important product to protect from stockouts.

### Recommendation

Management should prioritize replenishment and consider maintaining an appropriate safety-stock level while monitoring demand and supplier lead times.

---

# 📌 Management Recommendations

Based on the analysis, the following actions are recommended:

### 1. Protect High-Performing Products

Prioritize replenishment of high-revenue, high-margin products that are currently understocked.

### 2. Improve Margins on Major Revenue Drivers

Review pricing, supplier costs, discounts, logistics, and purchasing terms for high-revenue but low-margin products.

### 3. Reduce Excess Inventory

Limit additional purchasing of low-revenue, low-margin products with excessive stock.

Where appropriate, use:

- Promotions
- Bundling
- Cross-selling
- Controlled discounts

to improve inventory turnover.

### 4. Develop High-Margin Products

Increase the sales velocity of high-margin products through targeted marketing, cross-selling, better placement, and product bundling.

### 5. Improve Inventory Planning

Introduce product-level:

- Reorder points
- Safety-stock levels
- Minimum/maximum stock levels
- Demand monitoring
- Inventory turnover analysis

to reduce the likelihood of simultaneous overstocking and understocking.

### 6. Monitor Revenue Concentration

Because the Top 5 products contribute a significant share of total revenue, management should closely monitor their:

- Availability
- Pricing
- Margin
- Demand
- Supplier reliability

---

# 🛠️ Tools & Technologies

### Microsoft Excel

The project was developed primarily using Microsoft Excel, including:

- PivotTables
- PivotCharts
- Slicers
- Conditional Formatting
- Excel formulas
- Data cleaning
- Data transformation
- Dashboard design
- Custom number formatting
- Interactive visualizations

### VBA / Macros

VBA was used to enhance dashboard interactivity and automate visual elements.

Examples include:

- Interactive dashboard controls
- Show/hide dashboard elements
- Drill-down experiences
- Visual toggling
- User interaction enhancements

---

# 🔄 Analytical Workflow

The project followed a structured data-analysis workflow:

```text
Raw Sales Data
      ↓
Data Cleaning & Preparation
      ↓
Data Transformation
      ↓
PivotTables & Calculations
      ↓
KPI Development
      ↓
Product & Inventory Classification
      ↓
Interactive Visualizations
      ↓
Product Opportunity Matrix
      ↓
Business Insights
      ↓
Management Recommendations
