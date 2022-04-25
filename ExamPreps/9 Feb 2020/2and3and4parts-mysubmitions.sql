use fsd;


insert into coaches (first_name, last_name, salary, coach_level)
select p.first_name, p.last_name, p.salary*2, char_length(p.first_name) from players as p
where p.age>=45;


update coaches as c 
set c.coach_level = c.coach_level +1
where( select count(*)  as count 
from players_coaches as pc
where pc.coach_id = c.id
group by pc.coach_id
having count >=1 )and c.first_name like 'A$'
;

delete from players where age>=45;

/*section 3 querring*/
/*ex 5 */
select first_name, age, salary from players
order by salary desc;

/*ex 6 */
select p.id, concat(p.first_name, ' ', p.last_name) as full_name, p.age, p.position, p.hire_date from players as p
join skills_data as s
on s.id = p.skills_data_id
where age <23 and `position` like 'A' and hire_date is null and s.strength >50
order by p.salary, age;

/*ex 7*/
select t.name, t.established, t.fan_base, count(p.id) as players_count from teams as t
join players as p
on t.id = p.team_id
group by t.id
order by players_count desc, t.fan_base desc;

/*ex 7 second time */
SELECT t.`name`, t.established, t.fan_base, (SELECT COUNT(*) FROM players WHERE t.id = team_id) AS players_count
FROM teams AS t
ORDER BY players_count DESC, fan_base DESC;

/*ex 8 */
select max(sk.speed) as max_speed, towns.name as town_name from skills_data as sk 
right join players as p
on p.skills_data_id = sk.id
right join teams as t
on p.team_id = t.id
right join stadiums as s
on t.stadium_id = s.id
right join towns
on s.town_id = towns.id
where t.name not in ('Devify')
group by towns.name
order by max_speed desc , towns.name;

/*ex 9*/
select c.name, count(p.id) as total_count_of_players, sum(p.salary) as total_sum_of_salaries from countries as c
left join towns as t
on c.id=t.country_id
left join stadiums as s
on t.id = s.town_id
left join teams as tm 
on s.id = tm.stadium_id
left join players as p
on tm.id = p.team_id
group by c.name
order by total_count_of_players desc, c.name ;

/*section 4 programability*/
/*ex 10*/
delimiter $$ 

CREATE FUNCTION `udf_stadium_players_count` (stadium_name varchar(30))
RETURNS INT deterministic
BEGIN

RETURN (select count(p.id) from players as p
join teams as t
on p.team_id = t.id
join stadiums as s
on s.id = t.stadium_id
where s.name = stadium_name);
END;

/*ex 11*/
create procedure `udp_find_playmaker` (min_dribble_points INT, team_name VARCHAR (45))
begin
select concat_ws(' ', p.first_name, p.last_name) as full_name, p.age, p.salary, sd.dribbling, sd.speed, team_name from players as p
join teams as t
on t.id=p.team_id
join skills_data as sd
on sd.id = p.skills_data_id
where sd.dribling > min_dribble_points
and t.name = team_name
and sd.speed >(
select avg(speed) from skills_data)
order by sd.speed desc 
limit 1;
end $$