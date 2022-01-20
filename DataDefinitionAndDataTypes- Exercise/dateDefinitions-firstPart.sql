create schema `minions`;
use `minions`;

/*ex.1*/
create table `minions` (
`id` int not null primary key auto_increment,
`name` varchar(20) not null,
`age` int
);

create table `towns` (
`town_id` int not null primary key auto_increment,
`name` varchar(50)
);

/*ex.2*/
ALTER TABLE `towns` 
CHANGE COLUMN `town_id` `id` INT NOT NULL AUTO_INCREMENT ;

alter table `minions` 
add column `town_id` int not null;

ALTER TABLE `minions` 
ADD CONSTRAINT `fk_minions_towns`
  FOREIGN KEY (`town_id`)
  REFERENCES `towns` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  /*ex.3*/
  INSERT INTO `towns` (`id`, `name`) VALUES ('1', 'Sofia');
INSERT INTO `towns` (`id`, `name`) VALUES ('2', 'Plovdiv');
INSERT INTO `towns` (`id`, `name`) VALUES ('3', 'Varna');

INSERT INTO `minions` (`id`, `name`, `age`, `town_id`) VALUES ('1', 'Kevin', '22', '1');
INSERT INTO `minions` (`id`, `name`, `age`, `town_id`) VALUES ('2', 'Bob', '15', '3');
INSERT INTO `minions` (`id`, `name`, `age`, `town_id`) VALUES ('3', 'Steward', '', '2');

/*ex. 4*/ 
truncate table `minions`;

/*ex.5*/ 

drop table `minions`;
drop table `towns`;

/*ex.6*/
create schema `minions`;
use `minions`;

create table `people` (
`id` int not null primary key auto_increment,
 `name` varchar(200) not null,
 `picture` blob,
 `height` decimal(10,2),
 `weight` decimal(10,2),
 `gender` char not null,
 `birthdate` date not null,
 `biography` text
);


INSERT INTO `people` (`id`,`name`, `height`, `weight`, `gender`, `birthdate`, `biography`) VALUES ('1','me', '2.5', '20.3', 'f', '2010-05-20', 'rsdffsf');
INSERT INTO `people` (`id`,`name`, `height`, `weight`, `gender`, `birthdate`, `biography`) VALUES ('2','me', '2.5', '20.3', 'f', '2010-05-20', 'rsdffsf');
INSERT INTO `people` (`id`,`name`, `height`, `weight`, `gender`, `birthdate`, `biography`) VALUES ('3','me', '2.5', '20.3', 'f', '2010-05-20', 'rsdffsf');
INSERT INTO `people` (`id`,`name`, `height`, `weight`, `gender`, `birthdate`, `biography`) VALUES ('4','me', '2.5', '20.3', 'f', '2010-05-20', 'rsdffsf');
INSERT INTO `people` (`id`,`name`, `height`, `weight`, `gender`, `birthdate`, `biography`) VALUES ('5','me', '2.5', '20.3', 'f', '2010-05-20', 'rsdffsf');


/*ex 7 */ 

create table `users`(
`id` int not null Primary key auto_increment,
`username` varchar(30) unique,
`password` varchar(26),
`profile_picture` blob,
`last_login_time` timestamp,
`is_deleted` boolean
);

INSERT INTO `users` (`username`, `password`) VALUES ('me', '2568');
INSERT INTO `users` (`username`, `password`) VALUES ('az', '2568');
INSERT INTO `users` (`username`, `password`) VALUES ('some', '2568');
INSERT INTO `users` (`username`, `password`) VALUES ('ti', '2568');
INSERT INTO `users` (`username`, `password`) VALUES ('toi', '2568');


/*ex. 8*/
ALTER TABLE `users` 
CHANGE COLUMN `id` `id` INT NOT NULL ,
DROP PRIMARY KEY;

Alter table `users`
add constraint `pk_users` 
primary key users(id, username);

/*ex.9*/
ALTER TABLE `users` 
CHANGE COLUMN `last_login_time` `last_login_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ;

/*ex 10*/

ALTER TABLE `users` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`);
ALTER TABLE `users` 
ADD UNIQUE INDEX `username` (`username` ASC) VISIBLE;
;

/*ex 11*/

create schema `movies`;
use `movies`;

CREATE TABLE directors (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`director_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);
CREATE TABLE genres (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`genre_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);
CREATE TABLE categories (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);
CREATE TABLE movies (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(50) NOT NULL,
`director_id` INT NOT NULL,
`copyright_year` YEAR,
`length` TIME NOT NULL,
`genre_id` INT NOT NULL,
`category_id` INT NOT NULL,
`rating` DOUBLE(4,2),
`notes` TEXT
);
INSERT INTO `directors`(`director_name`)
VALUES
('TestDirector1'),
('TestDirector2'),
('TestDirector3'),
('TestDirector4'),
('TestDirector5');
INSERT INTO `genres`(`genre_name`)
VALUES
('TestGenre1'),
('TestGenre2'),
('TestGenre3'),
('TestGenre4'),
('TestGenre5');
INSERT INTO `categories`(`category_name`)
VALUES
('TestCategory1'),
('TestCategory2'),
('TestCategory3'),
('TestCategory4'),
('TestCategory5');
INSERT INTO `movies`(`title`, `director_id`, `length`, `genre_id`, `category_id`)
VALUES
('TestTitle1', 1, '02:10:10', 1, 1),
('TestTitle2', 2, '02:10:10', 2, 2),
('TestTitle3', 3, '02:10:10', 3, 3),
('TestTitle4', 4, '02:10:10', 4, 4),
('TestTitle5', 5, '02:10:10', 5, 5);


/*ex. 12*/

create schema car_rental;
use car_rental;


CREATE TABLE categories 
(
id INT PRIMARY KEY NOT NULL, 
category INT, 
daily_rate DECIMAL(10,2), 
weekly_rate DECIMAL(10,2), 
monthly_rate DECIMAL(10,2), 
weekend_rate DECIMAL(10,2)
);

CREATE TABLE cars 
(
id INT PRIMARY KEY NOT NULL, 
plate_number INT, 
make VARCHAR(30), 
model VARCHAR(30), 
car_year DATE, 
category_id INT NOT NULL, 
doors INT, 
picture BLOB, 
car_condition VARCHAR(100),
available VARCHAR(10)
);


CREATE TABLE employees 
(
id INT PRIMARY KEY NOT NULL, 
first_name VARCHAR(30) NOT NULL, 
last_name VARCHAR(30) NOT NULL, 
title VARCHAR(30), 
notes VARCHAR(100)
);

CREATE TABLE customers 
(
id INT PRIMARY KEY NOT NULL, 
driver_licence_number INT NOT NULL, 
full_name VARCHAR(100) NOT NULL, 
address VARCHAR(100), 
city VARCHAR(30), 
zip_code INT, 
notes VARCHAR(100)
);

CREATE TABLE rental_orders 
(id INT PRIMARY KEY NOT NULL, 
employee_id INT NOT NULL, 
customer_id INT NOT NULL, 
car_id INT NOT NULL, 
car_condition VARCHAR(100), 
tank_level INT,
kilometrage_start INT, 
kilometrage_end INT, 
total_kilometrage INT, 
start_date DATE, 
end_date DATE,
total_days INT, 
rate_applied INT, 
tax_rate DECIMAL(10,2), 
order_status VARCHAR(30), 
notes VARCHAR(100)
);

INSERT INTO categories(id,category,daily_rate,weekly_rate,monthly_rate,weekend_rate)
VALUES
(1,12,100,500,5000,200),
(2,14,200,800,9000,500),
(3,15,300,800,100000,1000);

INSERT INTO cars(id,plate_number,make,model,car_year,category_id,doors,picture,car_condition,available)
VALUES
(1,111,NULL,'bmw','1989-01-01',1,4,00010101,'good','yes'),
(2,114,NULL,'audi','2000-01-01',2,4,00010101,'good','yes'),
(3,115,NULL,'mercedes','2006-01-01',3,4,00010101,'good','yes');

INSERT INTO employees(id,first_name,last_name,title,notes)
VALUES
(1,'Ivan','Ivanov','worker',NULL),
(2,'Ivanka','Ivanova','worker',NULL),
(3,'Ivana','Ivanova','worker',NULL);

INSERT INTO customers(id,driver_licence_number,full_name,address,city,zip_code,notes)
VALUES
(1,3144343,'Georgi Georgiev',NULL,'Plovdiv',4000,NULL),
(2,314774343,'Georgina Georgieva',NULL,'Plovdiv',4000,NULL),
(3,314434333,'Haralampi Georgiev',NULL,'Plovdiv',4000,NULL);

INSERT INTO rental_orders(id,employee_id,customer_id,car_id,car_condition,tank_level,kilometrage_start,kilometrage_end,total_kilometrage,start_date,end_date,total_days,rate_applied,tax_rate,order_status,notes)
VALUES
(1,1,1,1,'good',100,5000,5000,10000,'1998-01-01','2008-01-01','36500',NULL,1000,'ordered',NULL),
(3,2,5,4,'good',1000,50000,50000,100000,'1998-01-01','2008-01-01','36500',NULL,1000,'ordered',NULL),
(2,3,4,5,'good',10000,500000,500000,1000000,'1998-01-01','2008-01-01','36500',NULL,1000,'ordered',NULL);


/*ex 13*/

create schema `soft_uni`;
use soft_uni;

create table `towns` (
`id` int primary key auto_increment,
`name` varchar(50) not null
);

create table `addresses`(
`id` int primary key auto_increment,
`address_text` varchar(100),
`town_id` int not null,
CONSTRAINT fk_addresses_towns FOREIGN KEY(town_id) REFERENCES towns(id)
); 

create table `departments`(
`id` int primary key auto_increment,
`name` varchar(45) not null
);

create table `employees` (
`id` int primary key auto_increment, 
`first_name` varchar(50) not null,
`middle_name`varchar(50),
`last_name` varchar(50) not null,
`job_title` varchar(80),
`department_id` int not null,
`hire_date` date,
`salary` decimal(10,2),
`address_id` int not null,
CONSTRAINT fk_employees_departments FOREIGN KEY(department_id) REFERENCES departments(id),
CONSTRAINT fk_employees_address FOREIGN KEY(address_id) REFERENCES addresses(id)
);


INSERT INTO towns(id,Name)
VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna'),
(4,'Burgas'); 

INSERT INTO departments(id,name)
VALUES
(1,'Engineering'),
(2,'Sales'),
(3,'Marketing'),
(4,'Software Development'),
(5,'Quality Assurance');

INSERT INTO addresses(id,address_text,town_id)
VALUES 
(1,'str odrin', 1),
(2,'str odrin', 4),
(3,'str odrin', 3),
(4,'str odrin', 2);


INSERT INTO employees(id,first_name,middle_name,last_name,job_title,department_id,hire_date,salary,address_id)
VALUES
(1,'Ivan','Ivanov','Ivanov','.NET Developer', 4,'2013-02-01',3500.00,4),
(2,'Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00,1),
(3,'Maria','Petrova','Ivanova','Intern',5,'2016-08-28',525.25,1),
(4,'Georgi','Terziev','Ivanov','CEO',2,'2007-12-09',3000.00,3),
(5,'Peter','Pan','Pan','Intern',3,'2016-08-28',599.88,2);


