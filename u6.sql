/*6)
*/

SELECT * FROM economies 

CREATE OR REPLACE TABLE country_info AS (
SELECT 
	e.country,
	c.abbreviation,
	e.year,
	e.GDP,
	e.population,
	e.gini,
	e.taxes,
	e.fertility,
	e.mortaliy_under5
FROM economies e
LEFT JOIN countries c ON e.country=c.country);

CREATE OR REPLACE TABLE t_matous_kochan_project_SQL_secondary_final AS (
SELECT 
	x1.country,
	x1.abbreviation,
	x1.year,
	x1.GDP,
	x2.GDP AS 'GDP_year-1',
	ROUND((x1.GDP-x2.GDP)/x2.GDP*100,2) AS 'GDP_grow',
	x1.population,
	x2.population AS 'population_year-1',
	ROUND((x1.population-x2.population)/x2.population*100,2) AS 'population_grow',
	x1.gini,
	x2.gini AS 'gini_year-1',
	ROUND((x1.gini-x2.gini)/x2.gini*100,2) AS 'gini_grow',
	x1.taxes,
	x2.taxes AS 'taxes_year-1',
	ROUND((x1.taxes-x2.taxes)/x2.taxes*100,2) AS 'taxes_grow',
	x1.fertility,
	x2.fertility AS 'fertility_year-1',
	ROUND((x1.fertility-x2.fertility)/x2.fertility*100,2) AS 'fertility_grow',
	x1.mortaliy_under5,
	x2.mortaliy_under5 AS 'mortaliy_under5_year-1',
	ROUND((x1.mortaliy_under5-x2.mortaliy_under5)/x2.mortaliy_under5*100,2) AS 'mortaliy_under5_grow'
   FROM country_info x1
LEFT JOIN country_info x2 ON x1.country=x2.country
	AND x1.abbreviation=x2.abbreviation
	AND x1.year=x2.year+1);
	
