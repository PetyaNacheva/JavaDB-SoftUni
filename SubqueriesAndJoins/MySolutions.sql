/*ex 1*/
select e.employee_id, e.job_title, e.address_id, a.address_text
from employees as e
join addresses as a
on e.address_id=a.address_id
order by e.address_id
limit 5;

/*ex 2*/
select e.`first_name`, e.`last_name`, t.`name` as `town`, a.address_text
from employees as e
join addresses as a
on e.address_id= a.address_id
join towns as t
on a.town_id=t.town_id
order by first_name asc, last_name
limit 5;

/*ex. 3*/
select e.employee_id, e.first_name, e.last_name, d.`name` as `department_name`
from employees as e
join departments as d
on e.department_id = d.department_id
where d.`name` like 'Sales'
order by e.employee_id desc;

/*ex 4*/
select e.employee_id, e.first_name, e.salary, d.`name` as department_name
from employees as e
join departments as d
on e.department_id=d.department_id
where e.salary >15000
order by d.department_id desc
limit 5;

/*ex 5*/
select e.employee_id, e.first_name
from employees as e
left join employees_projects as ep
on e.employee_id=ep.employee_id
left join projects as p
on ep.project_id= p.project_id
where p.project_id is null
order by e.employee_id desc
limit 3;

/*ex 6*/
select e.first_name, e.last_name, e.hire_date, d.`name` as dept_name
from employees as e
join departments as d
on e.department_id = d.department_id
where date(e.hire_date) > '1999-1-1' and d.`name` in('Sales', 'Finance')
order by e.hire_date;

/*ex 7*/
select e.employee_id, e.first_name, p.`name` as project_name
from employees as e
join employees_projects as ep
on e.employee_id = ep.employee_id
join projects as p
on p.project_id = ep.project_id
where date(p.start_date)>'2002-08-13' and p.end_date is null
order by first_name, p.`name`
limit 5;

/*ex. 8*/
select e.employee_id, e.first_name, if(year(p.start_date)>=2005, NULL, p.`name`) as project_name
from employees as e
join employees_projects as ep
on e.employee_id = ep.employee_id
join projects as p
on p.project_id = ep.project_id
where e.employee_id=24
order by project_name;

/*ex 9*/
select e.employee_id, e.first_name, e.manager_id, m.`first_name` as `manager_name` from employees as e
join employees as m
on e.manager_id = m.employee_id
where e.manager_id in(3, 7)
order by e.first_name;

/*ex 10*/
select e.employee_id, concat(e.first_name, ' ', e.last_name) as employee_name, concat(m.first_name, ' ', m.last_name) as manager_name, d.`name` as department_name from employees as e
join employees as m
on e.manager_id = m.employee_id
join departments as d
on e.department_id = d.department_id
order by e.employee_id
limit 5;

/*ex 11*/
select avg(salary) as min_average_salary from employees
group by `department_id`
order by `min_average_salary` limit 1;

/*ex 12*/
select c.country_code, m.mountain_range, p.peak_name, p.elevation from countries as c
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on mc.mountain_id = m.id
join peaks as p
on m.id=p.mountain_id
where c.country_code ='BG' and p.elevation >2835
order by p.elevation desc;

/*ex 13*/
select c.country_code, count(m.id) as mountain_range from countries as c
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on mc.mountain_id = m.id
where c.country_code in ('BG', 'RU', 'US')
group by c.country_code
order by mountain_range desc;

/*ex14*/
select c.country_name, r.river_name from countries as c
left join countries_rivers as cr
on c.country_code=cr.country_code
left join rivers as r
on cr.river_id= r.id
where continent_code = 'Af'
order by country_name
limit 5;

/*ex 15*/
select c.continent_code,
       c.currency_code,
       count(*) as 'currency_usage'
from countries as c
group by c.continent_code, c.currency_code
having currency_usage > 1
order by c.continent_code, c.currency_code;

/* ex16*/
select count(*) as country_count from countries as c
where c.country_code not in (select country_code from mountains_countries);

/*ex 17*/
select c.country_name, max(p.elevation) as highest_peak_elevation, max(r.length) as longest_river_length from countries as c
join countries_rivers as cr
on cr.country_code = c.country_code
join rivers as r
on r.id = cr.river_id
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on mc.mountain_id = m.id
join peaks as p
on p.mountain_id = m.id
group by c.country_code
order  by highest_peak_elevation desc, longest_river_length desc, c.country_name limit 5;
