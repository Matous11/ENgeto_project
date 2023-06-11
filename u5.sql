/*
5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
*/

CREATE OR REPLACE TABLE GDP AS(
SELECT 
	ecoA.year AS 'year_5',
	ecoA.GDP AS 'GDP_1',
	ecoB.year AS 'year_6',
	ecoB.GDP AS 'GDP_2',
	ROUND((ecoA.GDP-ecoB.GDP)/ecoB.GDP*100,2) AS 'GDP_grow'
FROM economies ecoA
JOIN economies ecoB ON ecoA.year=ecoB.year+1
WHERE ecoA.country = 'Czech Republic' AND ecoA.year BETWEEN 2006 AND 2021 AND ecoB.country = 'Czech Republic' AND ecoB.year BETWEEN 2005 AND 2018);

CREATE OR REPLACE TABLE t_matous_kochan_project_SQL_primary_final AS(
SELECT 
	com.id,
	com.code,
	com.year,
	com.pay_value_CZK,
	com.year_2,
	com.id_2,
	com.pay_value_CZK_2,
	com.x,
	com.year_3,
	com.food_code,
	com.name_3,
	com.price_3,
	com.price_unit,
	com.number_unit,
	com.year_4,
	com.price_4,
	concat(com.year,'-',com.year_2) AS year_7,
	com.commodity_grow_per,
	com.income_grow_per,
	GDP.GDP_grow
FROM comm_grow com
LEFT JOIN GDP ON com.year=GDP.year_5 AND com.year_2=GDP.year_6
ORDER BY com.code,com.name_3,com.year)

CREATE OR REPLACE TABLE GDP_grow AS (
SELECT 
	k.year,
	ROUND(AVG(k.GDP_grow),2) AS 'GDP_grow',
	ROUND(AVG(k.commodity_grow_per),2) AS 'commodity_grow_per',
	k.income_grow_per,
	l.year AS 'year+1',
	ROUND(AVG(l.commodity_grow_per),2) AS 'commodity_grow_per+1',
	ROUND(AVG(l.income_grow_per),2) AS 'income_grow_per+1'
FROM  t_matous_kochan_project_SQL_primary_final k
LEFT JOIN t_matous_kochan_project_SQL_primary_final l ON k.code=l.code AND k.year+1=l.year AND k.food_code =l.food_code
WHERE k.GDP_grow NOT BETWEEN -5 AND 5
GROUP BY k.year
ORDER BY k.code,k.name_3,k.year)



