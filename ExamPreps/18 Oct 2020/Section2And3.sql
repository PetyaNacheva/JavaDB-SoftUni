use `softUniStoresSystem`;

/*ex 2 insert*/
insert into `products_stores` (`product_id`, `store_id`) 
(select `id` as `product_id`, 1 from products where `id` not in ( select `product_id` from `products_stores`));

/*ex 3 update */

update employees
set  `manager_id` = 3, `salary` = salary-500
where year(hire_date) > 2003  and store_id not in(5, 14);


/*ex 4 delete */
delete from employees
where salary>=6000 and manager_id is not null;

/*section querring*/
/* ex 5 */
select first_name, middle_name, last_name, salary, hire_date from employees
order by hire_date desc;

/* ex 6*/
select pr.name as product_name, pr.price, pr.best_before, concat(left(pr.description, 10),'','...') as short_description, p.url from products as pr
join pictures as p
on pr.picture_id = p.id
 
where year(p.added_on) < 2019 and char_length(pr.description) >100 and pr.price>20
order by pr.price desc;

/*ex 7 */
select s.name, count(product_id) as product_count, round(avg(p.price),2) as avg from stores as s
left join products_stores as ps
on s.id= ps.store_id
left join products as p
on p.id=ps.product_id
group by s.name
order by product_count desc, avg desc, s.id;

/*ex 8*/
select concat(e.first_name, ' ', e.last_name) as full_name, s.name as store_name, a.name as address, e.salary from employees as e
join stores as s
on e.store_id=s.id
join addresses as a
on s.address_id = a.id
where e.salary<4000 and a.name like '%5%' and char_length(s.name) >8 and e.last_name like '%n';

/*ex 9*/
select reverse(s.name), concat(upper(t.name), '-', a.name) as full_address, count(e.id) as employees_count from stores as s
join addresses as a
on s.address_id=a.id
join employees as e
on e.store_id = s.id
join towns as t
on a.town_id = t.id 
group by s.id
having employees_count>=1
order by full_address;

/*section programmability */
/*ex 10*/
delimiter $$
create function `udf_top_paid_employee_by_store`(store_name varchar(50))
returns text deterministic
begin
return(
select concat(e.first_name,' ', e.middle_name, '. ', e.last_name, ' works in store for ',(year('2020-10-18')-year(e.hire_date)),' years') as full_info from employees as e
join stores as s
on e.store_id = s.id
where s.name = store_name
order by salary desc limit 1);
end$$


/*ex 11 procedure*/
create procedure `udp_update_product_price`(address_name varchar(50))
begin
update products as p
join products_stores as ps
on p.id= ps.product_id
join stores as s
on ps.store_id = s.id
join addresses as a
on a.id = s.address_id
join products as pr
on pr.id = ps.product_id
set p.price = if(address_name like '0%',p.price +100, p.price +200)
where a.name = address_name;
end