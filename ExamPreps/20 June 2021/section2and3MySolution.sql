use stc;

/*ex 2 Insert */
insert into clients (full_name, phone_number) (select concat(first_name, ' ', last_name) as full_name, concat('(088) 9999', id*2) as phone_number from drivers
where id >=10 and id<=20);


/*ex 3 Update */
update `cars`
set `condition` ='C'
where (mileage is null) or(mileage >=800000) 
and `year` <= 2010
and `make` not like 'Mercedes-Benz';


/*ex 4 Delete */

DELETE `clients` 
FROM `clients`
	LEFT JOIN
`courses` ON `clients`.`id` = `courses`.`client_id`
WHERE `client_id` IS NULL;

/*ex 5 Queriyng Cars*/
select make, model, `condition` from cars
order by id;

/*ex 6 drivers and cars */
select d.first_name, d.last_name, c.make, c.model, c.mileage from drivers as d
join cars_drivers as cd
on d.id= cd.driver_id
join cars as c
on cd.car_id = c.id
where mileage is not null
order by mileage desc, first_name;

/*7 number of courses */
select c.id, c.make, c.mileage, count(co.car_id) as count_of_courses, round(Avg(co.bill),2) as avg_bill from cars as c
left join courses as co 
on c.id=co.car_id
group by c.id
having count_of_courses<>2
order by count_of_courses desc, c.id;

/*ex 8 regular clients */
select cl.full_name, count(crs.id) as count_of_cars, sum(c.bill) as total_sum from clients as cl
join courses as c
on cl.id=c.client_id
join cars as crs
on c.car_id = crs.id
where full_name like '_a%'
group by cl.full_name
having count_of_cars >1
order by cl.full_name;

/*ex 9 full information about the courses */
select ad.`name`, case
when substring(time(co.start), 1,2) between 6 and 20 then 'Day'
else 'Night' end as `day_time`
,co.bill, cl.full_name, c.make, c.model, cat.`name` from clients as cl 
join courses as co
on cl.id=co.client_id
join cars as c
on co.car_id = c.id
join categories as cat
on c.category_id=cat.id
join addresses as ad
on co.from_address_id=ad.id
order by co.id;

/*ex 10 procedure */
DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_number VARCHAR (20)) 
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (SELECT count(cour.client_id)
FROM clients AS cl
	JOIN courses cour ON cl.id = cour.client_id
WHERE cl.phone_number = phone_number);
END$$

/*ex 11 procedure */
create procedure `udp_courses_by_address` (address_name varchar(100))
begin
select a.`name`, cl.full_name, (
case 
when c.bill<=20 then 'Low'
when c.bill <=30 then 'Medium'
else 'High' end ) as level_of_the_bill, cr.make, cr.`condition`, cat.`name`  from addresses as a
join courses as c
on a.id= c.from_address_id
join clients as cl
on c.client_id = cl.id
join cars as cr
on c.car_id=cr.id
join categories as cat
on cr.category_id=cat.id
having a.`name`= address_name
order by cr.make, cl.full_name;
end$$
