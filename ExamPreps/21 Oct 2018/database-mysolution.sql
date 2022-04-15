create schema cjms;
use cjms;


create table `planets` (
`id` int primary key auto_increment,
`name` varchar (30) not null
);

create table `spaceports` (
`id` int primary key auto_increment,
`name` varchar(50) not null,
`planet_id` int, 
constraint fk_spaceports_planets foreign key (`planet_id`)
references planets(`id`)
);

create table `spaceships` (
`id` int primary key auto_increment,
`name` varchar (50) not null,
`manufacturer` varchar(30) not null,
`light_speed_rate` int default 0
);

create table `journeys` (
`id` int primary key auto_increment,
`journey_start` datetime not null,
`journey_end` datetime not null,
`purpose` enum('Medical', 'Technical', 'Educational', 'Military') not null,
`destination_spaceport_id` int,
`spaceship_id` int,
constraint fk_journeys_spaceship foreign key (`spaceship_id`)
references spaceships(`id`),
constraint fk_journeys_spaceports foreign key (`destination_spaceport_id`)
references spaceports(`id`)
);

create table `colonists`(
`id` int primary key auto_increment,
`first_name` varchar (20) not null,
`last_name` varchar(20) not null,
`ucn` char(10) not null unique,
`birth_date` date not null
);

create table `travel_cards` (
`id` int primary key auto_increment,
`card_number` char(10) not null unique,
`job_during_journey` enum('Pilot', 'Engineer', 'Trooper', 'Cleaner', 'Cook') not null,
`colonist_id` int,
`journey_id` int,
constraint fk_travel_cards_colonists foreign key (`colonist_id`)
references colonists(`id`),
constraint fk_travel_cards_journeys foreign key (`journey_id`)
references journeys(`id`)
);