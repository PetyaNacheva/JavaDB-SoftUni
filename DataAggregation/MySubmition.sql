select * from wizzard_deposits;

/*ex 1*/
Select count(id) as count from wizzard_deposits;

/*ex 2*/
select max(`magic_wand_size`) as `longest_magic_wand` from `wizzard_deposits`;

/*ex 3*/
select `deposit_group`, max(`magic_wand_size`) as `longest_magic_wand` from `wizzard_deposits`
group by `deposit_group`
order by `longest_magic_wand`, `deposit_group`;

/*ex 4*/
select `deposit_group` from `wizzard_deposits`
group by `deposit_group`
order by avg(`magic_wand_size`) limit 1;


/*ex.5*/
select `deposit_group`, sum(`deposit_amount`) as `total_sum` from `wizzard_deposits`
group by `deposit_group`
order by `total_sum`;

/*ex 6*/
select `deposit_group`, sum(`deposit_amount`) as `total_sum` from `wizzard_deposits`
where `magic_wand_creator` like '%Ollivander%'
group by `deposit_group`
order by `deposit_group`;

/*ex 7*/
select `deposit_group`, sum(`deposit_amount`) as `total_sum` from `wizzard_deposits`
where `magic_wand_creator` like '%Ollivander%'
group by `deposit_group`
having  `total_sum`<150000
order by `total_sum` desc;

/*ex8*/
select deposit_group, magic_wand_creator, Min(`deposit_charge`) as `min_deposit_charge` from `wizzard_deposits`
group by `deposit_group`, `magic_wand_creator`
order by `magic_wand_creator`, `deposit_group`;

/*ex9*/
SELECT(
Case 
WHEN `age` between 0 and 10 then '[0-10]'
WHEN `age` between 11 and 20 then '[11-20]'
WHEN `age` between 21 and 30 then '[21-30]'
WHEN `age` between 31 and 40 then '[31-40]'
WHEN `age` between 41 and 50 then '[41-50]'
WHEN `age` between 51 and 60 then '[51-60]'
ELSE '[61+]'
end

) AS `age_group`, COUNT(*) as `wizard_count` from `wizzard_deposits`
Group by `age_group`
ORder by wizard_count;

/*ex10*/
select substring(`first_name`, 1, 1) as first_letter from `wizzard_deposits`
where deposit_group = 'Troll Chest'
group by first_letter
order by first_letter;


/*ex 11*/
select deposit_group, is_deposit_expired, avg(deposit_interest) from `wizzard_deposits`
where `deposit_start_date`>'1958-01-01'
group by deposit_group, is_deposit_expired
order by deposit_group desc, is_deposit_expired;

/*ex.12*/
use soft_uni;

select department_id, min(salary) as minimum_salary from employees
where department_id in (2,5,7) and year(hire_date) >=2000
group by department_id
order by department_id;

/*ex.13*/
create table new_table as
select * from employees
where salary>30000 and manager_id!=42;
update new_table 
set salary = salary +5000
where department_id=1;
select department_id, avg(salary) as avg_salary from new_table
group by department_id
order by department_id;
;


/*ex 14*/
select department_id, max(salary) as max_salary from employees
group by department_id
having max_salary < 30000 or max_salary > 70000
order by department_id;

/*ex 15*/
select count(*) as '' from employees
where manager_id is null;

/*ex 116*/
select e.department_id, (
select distinct e2.salary from `employees` e2
where e.department_id = e2.department_id
order by salary desc
limit 1 offset 2) as third_highest_salary from employees as e
group by department_id
having third_highest_salary is not null
order by e.department_id;

/*ex17*/
select first_name, last_name, department_id from employees as e
where e.salary>(
select avg(e2.salary) from employees as e2 
where e2.department_id =e.department_id)
order by department_id, employee_id limit 10;

/*ex 18*/
select department_id, sum(salary) as total_salary from employees
group by department_id
order by department_id;
