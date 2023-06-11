
/*
1)Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
*/




CREATE OR REPLACE TABLE income_1 AS (
SELECT  
		pay.id,
		pay.payroll_year AS 'pay_year',
		bra.name AS 'bra_name',
		pay.value AS 'pay_value',
		unit.name AS 'unit_name',
		cal.name AS 'cal_name',
		val.name AS 'val_name',
		bra.code
FROM czechia_payroll pay
JOIN czechia_payroll_value_type val  
	 ON value_type_code=val.code
	 AND pay.value_type_code = 5958
	 AND pay.calculation_code = 100 
JOIN czechia_payroll_unit unit 
	 ON pay.unit_code=unit.code
JOIN czechia_payroll_industry_branch bra
	 ON pay.industry_branch_code=bra.code
JOIN czechia_payroll_calculation cal 
	 ON pay.calculation_code=cal.code
GROUP BY bra.code,pay.payroll_year);


CREATE OR REPLACE TABLE income_2  AS (
SELECT  
		i1.id,
		i1.code,
		i1.bra_name,
		i1.pay_year,
		i1.pay_value,
		i1.unit_name,
		i2.id AS 'id_2',
		i2.pay_year AS 'pay_year_2',
		i2.pay_value AS 'pay_value_2',
		i2.unit_name AS 'unit_name_2',
		i1.cal_name,
		i1.val_name,
		CASE
			WHEN i1.pay_value-i2.pay_value>0 THEN 1
			ELSE 0
		END AS x
FROM income_1 i1
JOIN income_1 i2 ON i1.pay_year =i2.pay_year+1 AND i1.code=i2.code);