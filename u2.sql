/*
2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
**/


CREATE OR REPLACE TABLE commodity AS(
SELECT 
	cat.code,
	cat.name,
	cat.price_unit,
	ROUND(AVG(pri.value),2) AS 'price',
	YEAR(pri.date_from) AS 'year'
FROM czechia_price pri
JOIN czechia_price_category cat ON pri.category_code=cat.code
GROUP BY cat.name,YEAR(pri.date_from));


CREATE OR REPLACE TABLE commodity_2 AS(
SELECT 
	inc.id,
	inc.code,
	inc.pay_year AS 'year',
	inc.pay_value AS 'pay_value_CZK', 
	inc.id_2,
	inc.pay_year_2 AS 'year_2',
	inc.pay_value_2 'pay_value_CZK_2',
	inc.x,
	inc.pay_year AS 'year_3',
	com.code AS 'food_code',
	com.name AS 'name_3',
	com.price AS 'price_3',
	com.price_unit,
	ROUND(inc.pay_value/com.price) AS 'number_unit'
FROM income_2 inc
LEFT JOIN commodity com ON inc.pay_year=com.year
ORDER BY inc.code,com.name,inc.pay_year
);


CREATE OR REPLACE TABLE commodity_3 AS (
SELECT
	year,
	ROUND(AVG(pay_value_CZK)) AS 'pay_value_CZK',
	year_2,
	ROUND(AVG(pay_value_CZK_2)) AS 'pay_value_CZK_2',
	year_3,
	food_code,
	name_3,
	price_3,
	price_unit,
	ROUND(AVG(number_unit)) AS 'number_unit'
FROM commodity_2
WHERE year IN (2006,2018) AND food_code IN (114201,111301)
GROUP BY year, food_code 
ORDER BY food_code);




