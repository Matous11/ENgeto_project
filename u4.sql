/*
4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
*/

CREATE OR REPLACE TABLE comm_grow_3 AS (
SELECT * FROM (
SELECT 
	year_3,
	ROUND(AVG(commodity_grow_per),2) AS commodity_grow_per,
	ROUND(AVG(income_grow_per),2) AS income_grow_per,
CASE
	WHEN ROUND(AVG(commodity_grow_per),2) - ROUND(AVG(income_grow_per),2) > 10 Then 1
	ELSE 0
END AS xx
FROM comm_grow
GROUP BY year) k
WHERE xx =1)

