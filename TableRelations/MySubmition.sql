create schema `mySchema`;
use `mySchema`;

/*ex 1*/
create table `passports`(
`passport_id` int primary key auto_increment,
`passport_number` varchar(20) unique
);
alter table `passports` auto_increment=101;
INSERT INTO `passports`(`passport_number`) VALUes
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2');

create table `people`(
`person_id` int primary key auto_increment,
`first_name` varchar(50) not null,
`salary` decimal(10,2),
`passport_id` int unique
);
INSERT INTO `people`(`first_name`, `salary`,`passport_id`) VALUES 
('Roberto',43300.00,102),
('Tom',56100.00,103),
('Yana',60200.00,101);

alter table people
add constraint foreign key fk_passport_people(`passport_id`)
references `passports`(`passport_id`);


/*ex 2*/
create table `manufacturers`(
`manufacturer_id` int primary key auto_increment,
`name` varchar(50) not null,
`established_on` date
);

insert into `manufacturers`(`name`, `established_on`) 
values ('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

create table `models`(
`model_id` int primary key auto_increment,
`name` varchar(50) not null,
`manufacturer_id` int not null
);
alter table `models` auto_increment=101;

insert into `models`(`name`, `manufacturer_id`)
values('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);


alter table `models`
add constraint foreign key fk_manufacturers_models(`manufacturer_id`)
references `manufacturers`(`manufacturer_id`);


/*ex 3*/

create table `exams`(
`exam_id` int primary key auto_increment,
`name` varchar(50) not null
);
alter table `exams` auto_increment=101;
insert into `exams` (`name`) values 
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

create table `students` (
`student_id` int primary key auto_increment,
`name` varchar(60) not null
);

insert into `students` (`name`) values 
('Mila'),
('Toni'),
('Ron');

create table `students_exams`(
`student_id` int not null,
`exam_id` int not null,
constraint fk_student_exams primary key(`student_id`, `exam_id`),
constraint  fk_students_exams foreign key(`student_id`)
references `students`(`student_id`),
constraint  fk_exams_students foreign key(`exam_id`)
references `exams`(`exam_id`)
);

insert into `students_exams` (`student_id`, `exam_id`) values 
('1', '101'),
('1', '102'),
('2', '101'),
('3', '103'),
('2', '102'),
('2','103'); 

/*ex 4*/
create table `teachers`(
`teacher_id` int primary key auto_increment,
`name` varchar(60) not null,
`manager_id` int 
);
alter table `teachers` auto_increment = 101;
insert into `teachers` (`name`, `manager_id`) values
('John', null),
('Maya', '106'),
('Silvia', '106'),
('Ted', '105'),
('Mark', '101'),
('Greta', '101');


alter table `teachers` 
add constraint `fk_manager_teachers` foreign key(`manager_id`)
references `teachers`(`teacher_id`);

/*ex5*/
create schema `onlineStore`;
use onlineStore;

create table `cities` (
`city_id` int primary key auto_increment,
`name` varchar(50) 
);

create table `customers` (
`customer_id` int primary key auto_increment,
`name` varchar(50),
`birthday` date,
`city_id` int,
constraint fk_customer_cities foreign key (`city_id`)
references `cities`(`city_id`) 
);

create table `orders` (
`order_id` int primary key auto_increment,
`customer_id` int,
constraint fk_orders_customers foreign key (`customer_id`)
references `customers`(`customer_id`)
);

create table `order_items`(
`order_id` int,
`item_id` int,
constraint fk_order_item primary key (`order_id`, `item_id`),
constraint fk_order_orders foreign key (`order_id`)
references `orders`(`order_id`)
);

create table `item_types`(
`item_type_id` int primary key auto_increment,
`name` varchar(50)
);

create table `items`(
`item_id` int primary key auto_increment,
`name` varchar(50),
`item_type_id` int,
constraint fk_items_types foreign key (`item_type_id`)
references `item_types`(`item_type_id`)
);

alter table `order_items` 
add constraint fk_order_items foreign key (`item_id`)
references `items`(`item_id`);

/*ex6*/
create schema `univerisity`;
use `univerisity`;

create table `majors` (
`major_id` int primary key auto_increment,
`name` varchar(50)
);

create table `students` (
`student_id` int primary key auto_increment,
`student_number` varchar (12),
`student_name` varchar(50),
`major_id` int,
constraint `fk_students_majors` foreign key (`major_id`)
references `majors`(`major_id`)
);

create table `payments` (
`payment_id` int primary key auto_increment,
`payment_date` date,
`payment_amount` decimal(8,2),
`student_id` int,
constraint fk_payments_students foreign key (`student_id`)
references `students`(`student_id`)
);

create table `subjects` (
`subject_id` int primary key auto_increment,
`subject_name` varchar(50)
);

create table `agenda`(
`student_id` int,
`subject_id` int,
constraint `pk_agenda` primary key (`student_id`, `subject_id`),
constraint `fk_agenda_students` foreign key (`student_id`)
references `students`(`student_id`),
constraint `fk_agenda_subjects` foreign key (`subject_id`)
references `subjects` (`subject_id`)
);


/*ex7*/
use `geography`;

select m.`mountain_range`, p.`peak_name`, p.`elevation`
from `mountains` as m
join `peaks` as p
on p.`mountain_id`=m.`id`
where m.`mountain_range` = 'Rila'
order by p.`elevation` desc;

