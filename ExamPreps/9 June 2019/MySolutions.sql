/*ex 2*/
insert into cards (card_number,card_status, bank_account_id) 
(select reverse(full_name), 'Active', id from clients
where id between 191 and 200);

/*ex3 */
UPDATE employees_clients 
SET employee_id = (
SELECT ec.employee_id 
FROM (SELECT * FROM employees_clients) AS ec -- we clone the table!
GROUP BY ec.employee_id
ORDER BY COUNT(ec.client_id), ec.employee_id
LIMIT 1
)
WHERE employee_id = client_id;

/*ex 4*/
delete from employees
where id not in (select employee_id from employees_clients);

/*ex 5 */
select id, full_name from clients
order by id asc;

/*ex  6*/
select id, concat_ws(' ', first_name, last_name) as full_name, concat('$', salary) as salary, started_on from employees
where salary >= 100000
and started_on >= '2018-01-1'
order by salary desc, id;

/*ex 7*/
select c.id, concat(c.card_number, ' : ', cl.full_name) as card_token from cards as c
join bank_accounts as ba
on c.bank_account_id=ba.id
join clients as cl
on ba.client_id = cl.id
order by id desc;

/*ex 8 */
select concat_ws(' ', e.first_name, e.last_name) as name, e.started_on, count(c.id) as count_of_clients from employees as e
join employees_clients as ec 
on e.id = ec.employee_id
join clients as c
on c.id = ec.client_id
group by e.id
order by count_of_clients desc, e.id limit 5;

/*ex 9*/
select b.name, count(ca.id) as count_of_cards from branches as b
left join employees as e
on b.id = e.branch_id
left join employees_clients as ec
on e.id = ec.employee_id
left join clients as c 
on ec.client_id = c.id
left join bank_accounts as ba
on c.id = ba.client_id
left join cards as ca
on ba.id = ca.bank_account_id
group by b.name
order by count_of_cards desc, b.name;

/*ex 10*/
delimiter $$
CREATE FUNCTION `udf_client_cards_count` (`name` varchar(30))
RETURNS INT deterministic
BEGIN
RETURN (select count(ca.id) as cards from clients as c
join bank_accounts as ba
on c.id=ba.client_id
join cards as ca
on ba.id = ca.bank_account_id
where c.full_name = `name`);
END;$$

/*ex11*/

CREATE PROCEDURE `udp_clientinfo` ( full_name varchar(30))
BEGIN
select c.full_name, c.age, ba.account_number, concat('$', ba.balance) as balance from clients as c
join bank_accounts as ba
on c.id = ba.client_id
where c.full_name = full_name;
END

