# Nashville-Housing-Project
#  Nashville Housing Data Analysis (Power BI Project)

This project showcases a full end-to-end data analytics workflow starting from raw data cleaning in SQL to building a dynamic and interactive dashboard in Power BI. The dataset contains real estate property sales data from Nashville, Tennessee.

## Project Objectives
- Clean and prepare real estate transaction data.
- Perform data transformation and feature engineering using SQL.
- Build insightful visualizations to extract business insights using Power BI.

---

## Tools & Technologies
- **SQL Server** for data cleaning and transformation  
- **Power BI** for data visualization  
- **DAX** for calculated measures and columns

---

## Data Cleaning & Transformation (in SQL)

Key data cleaning steps performed in [`Nashville Housing.sql`](./Nashville Housing.sql):

1. **Convert date column to proper datatype**
   - Converted `SaleDate` column to `DATE`.

2. **Handle missing property addresses**
   - Used `JOIN` on `ParcelID` to fill null `PropertyAddress` values.

3. **Split compound address columns**
   - Extracted `PropertyAddress` into separate `splitPropertyAddress` and `splitPropertyCity`.
   - Split `OwnerAddress` into `splitOwnerAddress`, `splitOwnerCity`, and `splitOwnerState`.

4. **Standardize binary column values**
   - Converted `SoldAsVacant` from `0/1` to `Yes/No`.

5. **Remove duplicate rows**
   - Used `ROW_NUMBER()` with `PARTITION BY` to identify and delete duplicates.

6. **Drop unnecessary columns**
   - Removed columns that were replaced by new cleaned versions (`OwnerAddress`, `PropertyAddress`, `TaxDistrict`).

---

## Power BI Dashboard

Once the data was cleaned and loaded into Power BI, the following analyses and visualizations were developed:

### Key Visuals:
- **Sales trend over time** (monthly/yearly)
- **Average and total sale prices by city**
- **Property use distribution** (LandUse)
- **Comparison of local vs non-local owners**
- **Distribution of vacant vs occupied property sales**
- **Dynamic slicers for city, year, and land use filters**

### Insights Generated:
- Identified cities with the highest property activity.
- Found pricing patterns based on property features and usage type.
- Observed ownership trends (investor vs local buyer behavior).
---

##  Author
**[Abdullah Ragab]** – Data Analyst  
 [abdullahragab9334@gmail.com]   

---

## 📁 Files Included
- `Nashville Housing.sql` – SQL script for cleaning and transforming raw data.
- `nashville housing project.pbix` – Power BI dashboard file.
- `Nashville Housing.png` - screanshot.
