
-- LAB CRUD EXE 1 
SELECT `id`, `first_name`, `last_name`, `job_title` FROM `employees`
ORDER BY `id`;

-- EXE 2
SELECT `id`, CONCAT(`first_name`, ' ', `last_name`) AS `full_name` , `job_title`, `salary` FROM `employees`
WHERE `salary`> 1000
ORDER BY `id`; 

-- EXE 3
UPDATE `employees`
SET `salary` = `salary`+100
WHERE `job_title` = "Manager";
SELECT `salary` FROM `employees`;

-- EXE 4
SELECT * FROM `employees`
ORDER BY `salary` desc LIMIT 1;

-- EXE 5
SELECT * FROM `employees`
WHERE `department_id` = 4 AND `salary`>=1000;

-- EXE 6
DELETE FROM `employees`
WHERE `department_id` = 2 OR `department_id` = 1;
SELECT * FROM `employees`
ORDER BY `id`;
