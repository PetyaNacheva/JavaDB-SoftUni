create schema `softUniStoresSystem`;
use `softUniStoresSystem`;

create table `categories` (
`id` int primary key auto_increment,
`name` varchar(40) not null
);

create table `pictures`(
`id` int primary key auto_increment,
`url` varchar(100) not null,
`added_on` dateTime not null
);

create table `products`(
`id` int primary key auto_increment,
`name` varchar(40) not null,
`best_before` date,
`price` decimal(10,2) not null,
`description` text,
`category_id` int not null,
`picture_id` int not null,
constraint `fk_products_categories` foreign key (`category_id`)
references categories(`id`),
constraint `fk_products_picture` foreign key (`picture_id`)
references pictures(`id`)
);

create table `towns` (
`id` int primary key auto_increment,
`name` varchar(20) not null
);

create table `addresses` (
`id` int primary key auto_increment,
`name` varchar(50) not null,
`town_id` int not null,
constraint `fk_addresses_towns` foreign key (`town_id`)
references towns(`id`)
);

create table `stores` (
`id` int primary key auto_increment,
`name` varchar(20) not null,
`rating` float not null, 
`has_parking` tinyint(1),
`address_id` int not null,
constraint `fk_stores_addresses` foreign key(`address_id`)
references addresses(`id`)
);

create table `employees`(
`id` int primary key auto_increment,
`first_name` varchar(15) not null,
`middle_name` char(1),
`last_name` varchar(20) not null,
`salary` decimal(19,2) not null,
`hire_date` date not null,
`manager_id` int,
`store_id` int not null,
constraint `fk_employees_stores` foreign key(`store_id`)
references stores(`id`),
constraint `fk_employees_employees` foreign key(`manager_id`)
references employees(`id`)
);

create table `products_stores`(
`product_id` int not null,
`store_id` int not null,
constraint `pk_product_stores` primary key (product_id, store_id),
constraint `fk_products_sores_products` foreign key (`product_id`)
references products(`id`),
constraint `fk_products_stores_stores` foreign key (`store_id`)
references stores(`id`)
);


