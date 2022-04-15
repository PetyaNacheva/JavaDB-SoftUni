/*ex 1 insert */

INSERT INTO travel_cards (card_number, job_during_journey, colonist_id, journey_id)
SELECT(
CASE
	WHEN birth_date >'1980-01-01' THEN CONCAT_WS('',YEAR(c.birth_date), DAY(c.birth_date), LEFT(c.ucn,4))
    ELSE CONCAT_WS('',YEAR(c.birth_date), MONTH(c.birth_date), RIGHT(c.ucn,4))
END) AS card_number,
(
CASE
	WHEN c.id % 2 = 0 THEN 'Pilot'
	WHEN c.id % 3 = 0 THEN 'Cook'
	ELSE 'Engineer'
END)  AS job_during_journey,
c.id as colonist_id,
LEFT(c.ucn,1) AS journey_id
FROM colonists AS c
WHERE c.id BETWEEN 96 AND 100;

/*ex 2*/
update journeys 
set purpose = (
case 
when id%2 = 0 then 'Medical'
when id%3 = 0 then 'Technical'
when id%5 = 0 then 'Educational'
when id%7 = 0 then 'Military'
else purpose
end
);

/*ex3*/
delete from colonists
where id not in (select `colonist_id` from travel_cards);

/*ex4*/
select card_number, job_during_journey from travel_cards
order by card_number asc;

/*ex 5*/
select id, concat_ws(' ', first_name, last_name) as full_name, ucn from colonists
order by first_name, last_name, id;

/*ex 6*/
select id, journey_start, journey_end from journeys
where purpose = 'Military'
order by journey_start;

/*ex 7*/
select c.id, concat(c.first_name, ' ', c.last_name) as full_name from colonists as c
join travel_cards as tc
on c.id = tc.colonist_id
where job_during_journey = 'Pilot'
order by c.id;

/*ex8*/
select count(*) as count from colonists as c
join travel_cards as tc
on c.id = tc.colonist_id
join journeys as j
on tc.journey_id =j.id
where j.purpose = 'Technical';

/*ex 9 */
select s.name as spaceship_name, sp.name as spaceport_name from spaceships as s
join journeys as j
on s.id = j.spaceship_id
join spaceports as sp
on j.destination_spaceport_id = sp.id
order by s.light_speed_rate desc limit 1;

/*ex 10*/
select  s.name, s.manufacturer from spaceships as s
join journeys as j
on j.spaceship_id = s.id
join travel_cards as tc
on tc.journey_id  = j.id
join colonists as c
on c.id = tc.colonist_id
WHERE YEAR('2019-01-01')- YEAR(c.birth_date) < 30
AND tc.job_during_journey = 'Pilot'
ORDER BY s.name;

/*ex 11*/
select p.name as planet_name, s.name as spaceport_name from planets as p
join spaceports as s
on p.id = s.planet_id
join journeys as j
on s.id = j.destination_spaceport_id
where j.purpose = 'Educational'
order by spaceport_name desc;

/*ex 12*/
select p.name as planet_name, count(*) as journeys_count from planets as p
join spaceports as s
on p.id = s.planet_id
join journeys as j
on s.id = j.destination_spaceport_id
group by p.name
order by journeys_count desc, p.name;

/*ex 13*/
SELECT j.id, p.name AS planet_name, s.name AS spaceport_name, j.purpose AS journey_purpose
FROM journeys AS j
LEFT JOIN spaceports AS s ON j.destination_spaceport_id = s.id 
LEFT JOIN planets AS p ON p.id = s.planet_id
ORDER BY DATEDIFF(j.journey_end, j.journey_start) 
LIMIT 1;

/*ex 14*/
SELECT t.job_during_journey AS job_name
FROM travel_cards AS t
WHERE t.journey_id = 
( 
SELECT j.id 
FROM journeys AS j
ORDER BY DATEDIFF(j.journey_end, j.journey_start) DESC LIMIT 1
)
GROUP BY job_name
ORDER BY COUNT(job_name) LIMIT 1;

/*ex 15*/
DELIMITER $$
CREATE FUNCTION udf_count_colonists_by_destination_planet (planet_name VARCHAR (30)) 
RETURNS INT DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(*)
FROM colonists AS c
JOIN travel_cards AS t ON t.colonist_id = c.id
JOIN journeys AS j ON t.journey_id = j.id
JOIN spaceports AS s ON s.id = j.destination_spaceport_id
JOIN planets AS p ON s.planet_id = p.id
WHERE p.name = planet_name);
END $$

DELIMITER ;

/*ex 16*/
DELIMITER $$
CREATE PROCEDURE udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
DETERMINISTIC
BEGIN 
START TRANSACTION;
IF spaceship_name  NOT IN (SELECT `name` FROM spaceships) THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Spaceship you are trying to modify does not exists.';
    ROLLBACK;
ELSE 
UPDATE spaceships
SET light_speed_rate = light_speed_rate + light_speed_rate_increse
WHERE `name` = spaceship_name;
END IF;
COMMIT;
END $$

DELIMITER ;
