
-- EX 13 From DATE DEfinition and DATATypes 
CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns`(
`id` INT PRIMARY KEY auto_increment,
`name` VARCHAR(30) NOT NULL);

CREATE TABLE `adresses`(
`id` INT PRIMARY KEY auto_increment,
`adress_text` VARCHAR(100) NOT NULL,
`towns_id` INT NOT NULL,
CONSTRAINT fk_adresses_towns
FOREIGN KEY (`towns_id`)
REFERENCES `towns` (`id`)
);

CREATE TABLE `department`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL);

ALTER TABLE `department` rename `departments`;

CREATE TABLE `employees`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30) NOT NULL,
`middle_name` VARCHAR(30) NOT NULL,
`last_name` VARCHAR(30) NOT NULL,
`job_title` VARCHAR(20),
`salary` DECIMAL(10,2),
`department_id` INT,
`hire_date` DATE,
`adress_id` INT,
CONSTRAINT fk_employees_departments
FOREIGN KEY (`department_id`) 
REFERENCES `departments`(`id`),
CONSTRAINT fk_employees_adresses
FOREIGN KEY (`adress_id`)
REFERENCES `adresses`(`id`)
);

INSERT INTO `towns`
(`name`) VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO `departments`
(`name`) 
VALUES ('Engineering'),  ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');

INSERT INTO `employees` (`id`, `first_name`, `middle_name`, `last_name`, `job_title`, `salary`, `department_id`, `hire_date`,`address_id`)
VALUES (1, 'Ivan', 'Ivanov', 'Ivanov',	'.NET Developer', 3500.00,	4,	'2013-02-01', NULL),
(2,'Petar', 'Petrov', 'Petrov',	'Senior Engineer',4000.00, 1, '2004-03-02', NULL),
(3, 'Maria', 'Petrova', 'Ivanova',	'Intern', 525.25, 5, '2016-08-28', NULL),
(4, 'Georgi', 'Terziev', 'Ivanov',	'CEO',	3000.00, 2, '2007-12-09', NULL),
(5, 'Peter', 'Pan', 'Pan',	'Intern',	599.88, 3, '2016-08-28', NULL);	

-- EXE 14
SELECt * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

-- EXE 15
SELECT * FROM `towns` 
ORDER BY `name`;

SELECT * FROM `departments`
ORDER BY `name`;

SELECT * FROM `employees` 
ORDER BY `salary` DESC;

-- EXE 16
SELECT `name` FROM `towns`
ORDER BY `name`;
SELECT `name` FROM `departments`
ORDER BY `name`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY `salary` DESC;

-- EXE 17
UPDATE `employees` 
SET `salary` = `salary`*1.1;

SELECT `salary` from `employees`;

-- EXE 18 
truncate `employees`;
truncate `towns`;
truncate `departments`;
truncate `adresses`;
