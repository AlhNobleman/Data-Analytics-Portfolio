# Healthcare Analytics — Project Notes

## Purpose
Record the assumptions, validation checks, and evidence needed to make this Power BI healthcare analytics project reproducible and recruiter-friendly.

## Tools
- Power BI Desktop: report authoring, data model, DAX measures, interactions and visualizations.
- Power Query (M): data import, cleaning and transformation.
- DAX: KPI logic and filter-context-aware calculations.

## KPI validation checklist
- [ ] Confirm the grain of the source data (for example, one row per patient visit, admission or encounter).
- [ ] Define what counts as a patient: distinct patient IDs, encounters or rows.
- [ ] Confirm the date field used for YTD and the report's date range.
- [ ] Validate YTD measure behavior against a calendar/date table and selected dates.
- [ ] Confirm the Average Length of Stay unit and treatment of open/current admissions or missing discharge dates.
- [ ] Confirm the Bed Occupancy % numerator, denominator, time basis and whether it is a point-in-time or period measure.
- [ ] Test totals with all filters cleared and with individual slicers selected.
- [ ] Check missing values, duplicate records, invalid dates and unexpected categories in Power Query.
- [ ] Compare several dashboard figures with independently calculated values from the source data.

## Evidence to add
Export screenshots from Power BI Desktop and place them in `../Screenshots/`:
1. `dashboard-overview.png` — full report canvas with key KPIs.
2. `patient-trends.png` — patient trend visuals and date context.
3. `filters-and-details.png` — representative slicers and supporting breakdowns.

Use readable resolution and ensure screenshots do not expose personally identifiable or confidential patient information.

## Interpretation
Describe only insights that are directly supported by the displayed values and validated calculations. Avoid claiming that a KPI is above/below target unless a target is defined in the report or project brief.

## Dataset and privacy
Document the source, time range, row grain, and licensing here when confirmed. Do not commit real patient-identifiable or confidential healthcare data to a public repository.
