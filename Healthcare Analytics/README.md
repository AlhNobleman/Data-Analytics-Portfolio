# Healthcare Analytics Dashboard

## Project Overview
This project uses Microsoft Power BI to explore healthcare operations and present key performance indicators in an interactive dashboard. It is designed to help viewers examine patient activity and operational performance through summary metrics and visual reporting.

> **Portfolio note:** Findings and KPI definitions should be interpreted in the context of the dataset, reporting period, and business rules used in the report. This is an analytical portfolio project, not a clinical decision-support tool.

## Objectives
- Provide a consolidated view of important healthcare operations metrics.
- Make patient volume and operational indicators easier to monitor.
- Support filtering and comparison across the available reporting dimensions.
- Turn prepared data into an accessible management-facing dashboard.

## Tools and Technologies
- **Microsoft Power BI Desktop** — data model, measures, report layout, interactive visuals and dashboard development.
- **Power Query (M)** — data import, cleaning, type conversion, transformation and preparation.
- **DAX (Data Analysis Expressions)** — measures and KPI calculations used in the Power BI model.

## Dashboard KPIs
The report includes measures with names indicating:
- **Total Patients** — patient volume represented by the dataset and current filter context.
- **Total Patients YTD** — year-to-date patient count, subject to the report's date table and measure logic.
- **Average Length of Stay** — average recorded stay duration based on the model's calculation.
- **Bed Occupancy %** — occupancy indicator as defined in the report's measure.

Exact formulas, denominators, reporting dates and filter behavior should be checked in the PBIX model before using these metrics for operational decisions.

## Workflow
1. **Data preparation:** use Power Query to review source fields, data types, missing or inconsistent values, and transformation steps.
2. **Data modelling:** establish appropriate relationships and date logic where needed.
3. **Measure development:** define business metrics in DAX and validate them against the underlying records.
4. **Visualization:** present summary KPIs and supporting report visuals in Power BI.
5. **Validation:** test slicers, date filters, measure totals and edge cases to confirm the figures respond as expected.

## Repository Structure
```text
Healthcare Analytics/
├── README.md
├── practice health.pbix
├── Documentation/
│   └── project-notes.md
└── Screenshots/
    └── README.md
```

The screenshot folder contains a note on the recommended evidence to add. Dashboard screenshots should be exported from Power BI and saved there as PNG files.

## How to View
1. Download `practice health.pbix` from this folder.
2. Open it using Microsoft Power BI Desktop.
3. Refresh the data only if the source files and required access are available.
4. Use the report filters and slicers to explore the measures and views.

## Business Value
A well-designed healthcare dashboard can help managers quickly review patient volumes and selected operational indicators, identify patterns that merit investigation, and guide follow-up analysis. The dashboard should be used alongside validated source data and agreed KPI definitions.

## Limitations and Validation
- The PBIX report file is the interactive artifact; GitHub's code preview does not render Power BI visuals.
- The metric names above are taken from the report structure. The exact formulas and business definitions should be confirmed in Power BI before making claims about performance.
- No clinical advice or patient-level decisions should be made from this portfolio demonstration.

## Author
**Idris Shomoye**  
[GitHub](https://github.com/AlhNobleman) · [LinkedIn](https://www.linkedin.com/in/idris-shomoye-498849202)
