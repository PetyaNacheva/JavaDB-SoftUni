/*ex 1 */

Delimiter $$
CREATE PROCEDURE `usp_get_employees_salary_above_35000` ()
BEGIN
select first_name, last_name from employees
where salary>35000
order by first_name, last_name, employee_id;
END $$

/*ex 2 */
create procedure `ups_get_employees_salary_above` (number decimal(10,4))
begin(
select frist_name, last_name from employees;
where salary>=`number`
order by first_name, last_name, employee_id desc;)
end$$

/*ex3*/

CREATE PROCEDURE `usp_get_towns_starting_with` ( letter varchar(20))
BEGIN
select `name` as town_name from towns
where `name` like concat(letter, '%')
order by town_name;
END$$

/*ex 4*/
create procedure `usp_get_employees_from_town` (town_name varchar(20))
begin
select e.first_name, e.last_name from employees as e
join addresses as a
on e.address_id = a.address_id
join towns as t
on a.town_id = t.town_id
where t.`name` = town_name
order by e.first_name, e.last_name, e.employee_id desc;
end$$

/*ex 5*/
CREATE FUNCTION `ufn_get_salary_level`(emp_salary decimal(10,2))

RETURNS varchar(20)
deterministic
BEGIN
declare result varchar(20);
 if emp_salary <30000 then set result:='Low'; 
 elseif emp_salary>50000 then set result:='High';
 elseif emp_salary between 30000 and 50000 then set result:='Average';
 end If;
 return result;
END$$

/*ex 6 */

create procedure `usp_get_employees_by_salary_level` (level_of_salary varchar(20))
begin 
select fisrt_name, last_name from employees
where `ufn_get_salary_level` (salary) = level_of_salary
order by first_name desc, last_name desc;
end$$

/*ex 7 */
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
BEGIN
RETURN word REGEXP CONCAT('^[',set_of_letters,']+$');
END$$

/*ex 8*/
create procedure `usp_get_holders_full_name` ()
begin 
select concat(first_name, ' ', last_name) as full_name from account_holders
order by full_name, id;
end$$

/*ex 9*/
create procedure `usp_get_holders_with_balance_higher_than` (input int)
begin 
select first_name, last_name from account_holders as ah
join accounts as a
on ah.id=a.account_holder_id
group by a.account_holder_id
having sum(balance)>input
order by a.account_holder_id;
end$$

/*ex 10*/
create function `ufn_calculate_future_value` (initial_sum decimal(10,4), yearly_rate decimal(10,4), years int)
returns decimal(10,4)
deterministic
begin 
return (initial_sum*(power((1+yearly_rate),years)));
end$$

/*ex 11*/
create procedure `usp_calculate_future_value_for_account` (account_id int, interest_rate decimal(10,4))
begin 
select ac.id, ah.first_name, ah.last_name, ac.balance as current_balance, (`ufn_calculate_future_value`(ac.balance, interest_rate, 5)) as balance_in_5_years from accounts as ac
join account_holders as ah
on ah.id=ac.account_holder_id
where ac.id = account_id;
end$$

/*ex 12*/
create procedure `usp_deposit_money` (account_id int, money_amount decimal(10,4))
begin 
update accounts 
set balance = if (money_amount>0, round(balance + money_amount, 4) , balance)  
where id = account_id;
end$$

/*ex 13*/
create procedure `usp_withdraw_money` (account_id int, money_amount decimal(20,4))
begin
update accounts 
set balance = if((money_amount>0 and balance>=money_amount), round(balance-money_amount, 4), balance)
where id=account_id;
end$$

/*ex 14*/
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
START TRANSACTION;
IF from_account_id NOT IN(SELECT id FROM accounts) THEN
ROLLBACK;
ELSEIF to_account_id NOT IN (SELECT id FROM accounts) THEN
ROLLBACK;
ELSEIF from_account_id=to_account_id THEN
ROLLBACK;
ELSEIF amount<=0 THEN
ROLLBACK;
ELSEIF (SELECT balance FROM accounts WHERE from_account_id=id) < amount THEN 
ROLLBACK;
ELSE 

UPDATE accounts
SET balance=balance-amount
where id=from_account_id;

UPDATE accounts
SET balance=balance+amount
where id=to_account_id;

END IF;
COMMIT;
END;

/*ex 15*/
CREATE TABLE logs
(
log_id INT PRIMARY KEY auto_increment, 
account_id INT, 
old_sum DECIMAL(19,4), 
new_sum DECIMAL(19,4)
);
CREATE TRIGGER account_logs
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES(NEW.id, OLD.balance, NEW.balance);
END;

/*ex 16*/
CREATE table `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT,
old_sum  DECIMAL(20,4),
new_sum DECIMAL(20,4));
CREATE TRIGGER account_logs
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES(NEW.id, OLD.balance, NEW.balance);
END;
CREATE TABLE notification_emails (
    id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject VARCHAR(200),
    body VARCHAR(200)
);


CREATE TRIGGER new_email_for_each_log
AFTER UPDATE
ON `logs`
FOR EACH ROW
BEGIN
    INSERT INTO notification_emails(recipient, subject, body)
    VALUES(NEW.account_id, concat('Balance change for account: ','', NEW.account_id),
    concat_ws(' ','On',NOW(), 'your balance was changed from', NEW.old_sum, NEW.new_sum));
END;
