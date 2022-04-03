/*ex.1*/
SELECT `first_name`, `last_name` FROM `employees`
where `first_name` like 'Sa%'
order by `employee_id`;

/*ex.2*/
select `first_name`, `last_name` from `employees`
where `last_name` like '%ei%'
order by `employee_id`;

/*ex. 3*/
select `first_name` from `employees` 
where `department_id` in(3,10) and year (`hire_date`)>=1995 and year(`hire_date`)<= 2005
order by `employee_id`;

/*ex. 4*/
select `first_name`, `last_name` from `employees` 
where `job_title` not like '%engineer%'
order by `employee_id`;

/*ex.5*/
select `name` from `towns`
where char_length(`name`) between 5 and 6
order by `name`;

/*ex.6*/
select `town_id`, `name` from `towns`
where left(`name`, 1) in ('m', 'k', 'b', 'e')
order by `name`;

/*ex.7*/
select `town_id`, `name` from `towns`
where left(`name`, 1) not in ('r','b', 'd')
order by `name`;

/*ex.8*/
create view `v_employees_hired_after_2000` as 
select `first_name`, `last_name` from `employees`
where year(`hire_date`) >2000;

/*ex.9*/
select `first_name`, `last_name` from `employees` 
where char_length(`last_name`) =5;

/*ex.10*/
select `country_name`, `iso_code` from `countries`
where `country_name` like '%a%a%a%'
order by `iso_code`;

/*ex.11*/
select `peak_name`, `river_name`, lower(concat(`peak_name`, substring(`river_name`,2))) as `mix` from `peaks`, `rivers`
where right(lower(`peak_name`),1) = left(lower(`river_name`),1)
order by `mix`;

/*ex.12*/
select `name`, date_format(`start`, '%Y-%m-%d') from `games`
where year(`start`) between 2011 and 2012
order by `start`, `name` limit 50;

/*ex.13*/
select `user_name` ,
substring(`email`, locate('@', `email`)+1) as `email_provider`
from `users`
order by `email_provider`, `user_name`;

/*ex.14*/ 
select `user_name`, `ip_address` from `users`
where `ip_address` like '___.1%.%.___'
order by `user_name`;

/*ex.15*/
SELECT `name`, 
(
CASE 
WHEN HOUR(`start`) <= 11 THEN 'Morning'
WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END
) AS `part_of_the_day`,
(
CASE WHEN`duration`<4 THEN 'Extra Short' 
WHEN`duration`<7 THEN 'Short'
WHEN`duration`<11 THEN 'Long'
ELSE 'Extra Long'
END
 ) AS 'Duration' FROM `games`;
 
 
 /*ex.16*/
 SELECT `product_name`, `order_date` , DATE_ADD(`order_date`, INTERVAL 3 DAY) AS 'pay_due',
 DATE_ADD(`order_date`, INTERVAL 1 month) AS 'delivery_due'
 FROM `orders`;
