/*
3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
*/
CREATE OR REPLACE TABLE comm_grow AS(
SELECT
	com2a.id,
	com2a.code,
	com2a.year,
	com2a.pay_value_CZK,
	com2a.id_2,
	com2a.year_2,
	com2a.pay_value_CZK_2,
	com2a.x,
	com2a.year_3,
	com2a.food_code,
	com2a.name_3,
	com2a.price_3,
	com2a.price_unit,
	com2a.number_unit,
	com2b.year_3 AS 'year_4',
	com2b.price_3 AS 'price_4',
	ROUND((com2a.price_3 - com2b.price_3)/com2b.price_3*100,2) AS 'commodity_grow_per',
	ROUND((com2a.pay_value_CZK-com2a.pay_value_CZK_2)/com2a.pay_value_CZK_2*100,2) AS 'income_grow_per'
FROM commodity_2  com2a
LEFT JOIN commodity_2  com2b ON com2a.year_3=com2b.year_3+1 AND com2a.name_3=com2b.name_3 AND com2a.code=com2b.code
WHERE com2a.year_3 BETWEEN 2006 AND 2018
ORDER BY com2a.code, com2a.name_3,com2a.year
);

CREATE OR REPLACE TABLE comm_grow_2 AS (
SELECT 
	name_3,
	ROUND(AVG(commodity_grow_per),2) as 'commodity_grow_per' 
FROM comm_grow
WHERE name_3 IS NOT NULL
GROUP BY name_3
ORDER BY ROUND(AVG(commodity_grow_per),2));