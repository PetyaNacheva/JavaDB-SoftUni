
/*ex 2 insert*/
insert into addresses (address, town, country, user_id) 
select username, `password`, ip, age from users
where gender = 'M';

select * from addresses;

/*ex 3 update */
update addresses
set country = (
case
when country like 'B%' then 'Blocked'
when country like 'T%' then 'Test'
when country like 'P%' then 'In Progress'
else country
end
);

/*ex 4 delete*/
delete from addresses
where id%3=0;

/*ex 5 users*/
select username, gender, age from users
order by age desc, username;


/*ex 6 */
select p.id, p.date as date_and_time, p.description, count(distinct c.id) as commentsCount from photos as p
join comments as c
on c.photo_id = p.id
group by p.id
order by commentsCount desc, p.id
limit 5;

/*ex 7*/
select concat(u.id, ' ', u.username) as id_username, u.email from users as u
join users_photos as up
on up.user_id = u.id
where u.id = up.photo_id
order by u.id; 

/*ex 8*/
select distinct p.id as photo_id, count(distinct l.id) as likes_count, count(distinct c.id) as comments_count from photos as p
join likes as l
on p.id = l.photo_id
join comments as c
on p.id = c.photo_id
group by p.id
order by likes_count desc, p.id;


/*ex 9*/
select concat(left(description, 30), '...') as summary, date from photos
where day(date) = 10
order by date desc;


/*ex 10 get users photos count*/
delimiter $$
CREATE FUNCTION `udf_users_photos_count` (`user` varchar(30))
RETURNS INTEGER
deterministic
BEGIN

RETURN (select count(*) from photos as p
join users_photos as up
on up.photo_id = p.id
join users as u 
on u.id = up.user_id
where u.username =user);
END$$

delimiter ;

select udf_users_photos_count('ssantryd') as photosCount;

/*ex 11 procedure*/
delimiter $$
CREATE PROCEDURE `udp_modify_user` (address VARCHAR(30), town VARCHAR(30))
deterministic
BEGIN
update users as u
join addresses as a
on a.user_id = u.id
set u.age = u.age +10 
where a.address = address and a.town = town;
END
$$

delimiter ;
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';
CALL udp_modify_user ('97 Valley Edge Parkway', 'Divinópolis');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';