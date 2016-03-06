DROP DATABASE IF EXISTS `imagine_salon`;
CREATE DATABASE `imagine_salon`;
USE `imagine_salon`;

CREATE TABLE `customer` (
    `customer_id`   int(4) NOT NULL AUTO_INCREMENT,
    `first`         varchar(35) NOT NULL,
    `last`          varchar(35) NOT NULL,
    `email`         varchar(50),
    `address`       varchar(75),
    `city`          varchar(50),
    `state`         char(2),
    `zip`           char(5),
    `phone`         varchar(12),
    `alt_phone`     varchar(12),
    `notes`         varchar(255),
    `preferred_staff`    int(4),
    `discount_type`     int(4),
    `referral_source`   varchar(50),
    PRIMARY KEY         (`customer_id`)
); 
    
CREATE TABLE `appointment` (
    `appointment_id`    int(8) NOT NULL AUTO_INCREMENT,
    `service_id`        int(4),
    `customer_id`       int(4) NOT NULL,
    `promotion_id`      int(4),
    `notes`             varchar(255),
    `start_timestamp`   timestamp NOT NULL,
    `end_timestamp`     timestamp,
    `repeat`            boolean,
    `staff_id`          int(4),
    `resources`         varchar(255),
    `status_code`       int(4),
    `check_in`          timestamp,
    PRIMARY KEY         (`appointment_id`)
); 

CREATE TABLE `staff` (
    `staff_id`      int(4) NOT NULL AUTO_INCREMENT,
    `first`         varchar(35) NOT NULL,
    `last`          varchar(35) NOT NULL,
    `email`         varchar(50),
    `address`       varchar(75),
    `city`          varchar(50),
    `state`         char(2),
    `zip`           char(5),
    `phone`         varchar(12) NOT NULL,
    `alt_phone`     varchar(12),
    `role_id`       int(4) NOT NULL,
    `services`      varchar(255),
    `status_code`   int(4),
    PRIMARY KEY     (`staff_id`)
); 
    
CREATE TABLE `service` (
    `service_id`    int(4) NOT NULL AUTO_INCREMENT,
    `name`          varchar(35) NOT NULL,
    `category`      varchar(35) NOT NULL,
    `service_code`  char(4) NOT NULL,
    `add_on`        int(4),
    `timeblock`     int(3) NOT NULL,
    `role_id`       char(2) NOT NULL,
    `price`         decimal(5,2) NOT NULL,
    `availability_id` int(4),
    `status_code`     int(4),
    PRIMARY KEY       (`service_id`)
); 

CREATE TABLE `product` (
    `product_id`    int(4) NOT NULL AUTO_INCREMENT,
    `name`          varchar(35) NOT NULL,
    `upc_code`      int(25) NOT NULL,
    `category`      varchar(35),
    `size`          varchar(35),
    `notes`         varchar(255),
    `vendor_id`     int(4) NOT NULL,
    `quantity`      int(3) NOT NULL DEFAULT 0,
    `status_code`   int(4) NOT NULL,
    `wholesale_cost` decimal(5,2) NOT NULL DEFAULT 0.00,
    `retail_price`   decimal(5,2) NOT NULL DEFAULT 0.00,
    `brand`          varchar(35) NOT NULL,
    PRIMARY KEY      (`product_id`)
); 

CREATE TABLE `vendor` (
    `vendor_id`     int(4) NOT NULL AUTO_INCREMENT,
    `name`          varchar(35) NOT NULL,
    `order_details` varchar(255),
    `notes`         varchar(255),
    PRIMARY KEY     (`vendor_id`)
); 

CREATE TABLE `resource` (
    `resource_id` int(4) NOT NULL AUTO_INCREMENT,
    `name`              varchar(35) NOT NULL,
    `description`       varchar(255),
    `notes`             varchar(255),
    `type`              varchar(35) NOT NULL,
    `availability_id`   int(4),
    `status_code`       int(4),
    PRIMARY KEY         (`resource_id`)
); 

CREATE TABLE `promotion` (
`promotion_id`      int(4) NOT NULL AUTO_INCREMENT,
`name`              varchar(35) NOT NULL,
`description`       varchar(255),
`start_date`        date,
`end_date`          date,
`discount_type`     int(4),
`available`         boolean,
`limit`             int(4),
`require_code`      boolean,
`valid_codes`       varchar(255),
`valid_services`    varchar(255),
PRIMARY KEY (`promotion_id`)
); 

CREATE TABLE `shift` (
    `shift_id`      int(4) NOT NULL AUTO_INCREMENT,
    `shift_start`   timestamp NOT NULL,
    `shift_end`     timestamp,
    `staff_id`      int(4),
    PRIMARY KEY     (`shift_id`)
); 

CREATE TABLE `add_on_service` (
    `add_on_id` int(4) NOT NULL AUTO_INCREMENT,
    `name`      varchar(35) NOT NULL,
    `timeblock` int(3) NOT NULL,
    PRIMARY KEY (`add_on_id`)
); 

CREATE TABLE `role` (
    `role_id`   int(4) NOT NULL AUTO_INCREMENT,
    `name`      varchar(35) NOT NULL,
    PRIMARY KEY (`role_id`)
); 

CREATE TABLE `availability` (
    `availability_id`   int(4) NOT NULL AUTO_INCREMENT,
    `staff_id`          int(4),
    `resource_id`       int(4),
    `service_id`        int(4),
    `monday_start`      timestamp NOT NULL,
    `tuesday_start`     timestamp NOT NULL,
    `wedday_start`      timestamp NOT NULL,
    `thursday_start`    timestamp NOT NULL,
    `friday_start`      timestamp NOT NULL,
    `saturday_start`    timestamp NOT NULL,
    `sunday_start`      timestamp NOT NULL,
    `monday_end`        timestamp NOT NULL,
    `tuesday_end`       timestamp NOT NULL,
    `wedday_end`        timestamp NOT NULL,
    `thursday_end`      timestamp NOT NULL,
    `friday_end`        timestamp NOT NULL,
    `saturday_end`      timestamp NOT NULL,
    `sunday_end`        timestamp NOT NULL,
    PRIMARY KEY         (`availability_id`)
); 

CREATE TABLE `discount` (
    `discount_type` int(4) NOT NULL AUTO_INCREMENT,
    `name`          varchar(35) NOT NULL,
    `percentage`    decimal(5,2),
    `amount`        decimal(5,2),
    PRIMARY KEY     (`discount_type`)
); 

CREATE TABLE `status` (
    `status_code` int(4) NOT NULL AUTO_INCREMENT,
    `name`        varchar(35) NOT NULL,
    PRIMARY KEY   (`status_code`)
); 

CREATE TABLE `change` (
    `change_id`         int(4) NOT NULL AUTO_INCREMENT,
    `name`              varchar(35) NOT NULL,
    `table_name`        varchar(35) NOT NULL,
    `column_name`       varchar(35) NOT NULL,
    `previous_value`    varchar(255) NOT NULL,
    `current_value`     varchar(255) NOT NULL,
    `change_timestamp`  timestamp DEFAULT current_timestamp,
    `is_undone`         boolean DEFAULT false,
    PRIMARY KEY         (`change_id`)
); 

CREATE TABLE `example_phpmvc` (
  `group_id`        int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_parent`    int(11) NOT NULL DEFAULT '0',
  `group_name`      varchar(220) DEFAULT NULL,
  PRIMARY KEY       (`group_id`)
);

ALTER TABLE customer
ADD FOREIGN KEY (discount_type) 
REFERENCES discount(discount_type),
    ADD FOREIGN KEY (preferred_staff)
    REFERENCES staff(staff_id);

ALTER TABLE appointment
ADD FOREIGN KEY (service_id)
REFERENCES service(service_id),
    ADD FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id),
    ADD FOREIGN KEY (promotion_id)
    REFERENCES promotion(promotion_id),
    ADD FOREIGN KEY (staff_id)
    REFERENCES staff(staff_id),
    ADD FOREIGN KEY (status_code)
    REFERENCES status(status_code);

ALTER TABLE staff
ADD FOREIGN KEY (role_id)
REFERENCES role(role_id),
    ADD FOREIGN KEY (status_code)
    REFERENCES status(status_code);
    
ALTER TABLE service
ADD FOREIGN KEY (add_on)
REFERENCES add_on_service(add_on_id),
    ADD FOREIGN KEY (role_id)
    REFERENCES role(role_id),
    ADD FOREIGN KEY (availability_id)
    REFERENCES availability(availability_id),
    ADD FOREIGN KEY (status_code)
    REFERENCES status(status_code);
    
ALTER TABLE product
ADD FOREIGN KEY (vendor_id)
REFERENCES vendor(vendor_id),
    ADD FOREIGN KEY (status_code)
    REFERENCES status(status_code);
    
ALTER TABLE resource
ADD FOREIGN KEY (availability_id)
REFERENCES availability(availability_id),
    ADD FOREIGN KEY (status_code)
    REFERENCES status(status_code);
    
ALTER TABLE promotion
ADD FOREIGN KEY (discount_type)
REFERENCES discount(discount_type);

ALTER TABLE shift
ADD FOREIGN KEY (staff_id)
REFERENCES staff(staff_id);

ALTER TABLE availability
ADD FOREIGN KEY (staff_id)
REFERENCES staff(staff_id),
    ADD FOREIGN KEY (resource_id)
    REFERENCES resource(resource_id),
    ADD FOREIGN KEY (service_id)
    REFERENCES service(service_id);
    
LOCK TABLES `customer` WRITE;

INSERT INTO `customer` (`first`, `last`, `address`, `city`, `state`, `zip`, `phone`, `alt_phone`, `email`)
VALUES
	('James', 'Button', '6649 N Blue Gum St', 'New Orleans', 'LA', '70116', '504-621-8927', '504-845-1427', 'jbutt@gmail.com'), 
    ('Josephine', 'Darakjy', '4 B Blue Ridge Blvd', 'Brighton', 'MI', '48116', '810-292-9388', '810-374-9840', 'josephine_darakjy@darakjy.org'), 
    ('Art', 'Venere', '8 W Cerritos Ave Apt 54', 'Bridgeport', 'NJ', '8014', '856-636-8749', '856-264-4130', 'art@venere.org'), 
    ('Lenna', 'Paprocki', '639 Main St', 'Anchorage', 'AK', '99501', '907-385-4412', '907-921-2010', 'lpaprocki@hotmail.com'), 
    ('Donette', 'Foller', '34 Center St', 'Hamilton', 'OH', '45011', '513-570-1893', '513-549-4561', 'donette.foller@cox.net'), 
    ('Simona', 'Morasca', '3 Mcauley Dr', 'Ashland', 'OH', '44805', '419-503-2484', '419-800-6759', 'simona@morasca.com'), 
    ('Mitsue', 'Tollner', '7 Eads St', 'Chicago', 'IL', '60632', '773-573-6914', '773-924-8565', 'mitsue_tollner@yahoo.com'), 
    ('Leota', 'Dilliard', '7 W Jackson Blvd', 'San Jose', 'CA', '95111', '408-752-3500', '408-813-1105', 'leota@hotmail.com'), 
    ('Sage', 'Wieser', '5 Boston Ave Apt 88', 'Sioux Falls', 'SD', '57105', '605-414-2147', '605-794-4895', 'sage_wieser@cox.net'), 
    ('Kris', 'Marrier', '228 Runamuck Pl Apt 2808', 'Baltimore', 'MD', '21224', '410-655-8723', '410-804-4694', 'kris@gmail.com'), 
    ('Minna', 'Amigon', '2371 Jerrold Ave', 'Kulpsville', 'PA', '19443', '215-874-1229', '215-422-8694', 'minna_amigon@yahoo.com'), 
    ('Abel', 'Maclead', '37275 St  Rt 17m M', 'Middle Island', 'NY', '11953', '631-335-3414', '631-677-3675', 'amaclead@gmail.com'), 
    ('Kiley', 'Caldarera', '25 E 75th St Apt 69', 'Los Angeles', 'CA', '90034', '310-498-5651', '310-254-3084', 'kiley.caldarera@aol.com'), 
    ('Graciela', 'Ruta', '98 Connecticut Ave Nw', 'Chagrin Falls', 'OH', '44023', '440-780-8425', '440-579-7763', 'gruta@cox.net'), 
    ('Cammy', 'Albares', '56 E Morehead St', 'Laredo', 'TX', '78045', '956-537-6195', '956-841-7216', 'calbares@gmail.com'), 
    ('Mattie', 'Poquette', '73 State Road 434 E', 'Phoenix', 'AZ', '85013', '602-277-4385', '602-953-6360', 'mattie@aol.com'), 
    ('Meaghan', 'Garufi', '69734 E Carrillo St', 'Mc Minnville', 'TN', '37110', '931-313-9635', '931-235-7959', 'meaghan@hotmail.com'), 
    ('Gladys', 'Rim', '322 New Horizon Blvd', 'Milwaukee', 'WI', '53207', '414-661-9598', '414-377-2880', 'gladys.rim@rim.org'), 
    ('Yuki', 'Whobrey', '1 State Route 27', 'Taylor', 'MI', '48180', '313-288-7937', '313-341-4470', 'yuki_whobrey@aol.com'), 
    ('Fletcher', 'Flosi', '394 Manchester Blvd', 'Rockford', 'IL', '61109', '815-828-2147', '815-426-5657', 'fletcher.flosi@yahoo.com'), 
    ('Bette', 'Nicka', '6 S 33rd St', 'Aston', 'PA', '19014', '610-545-3615', '610-492-4643', 'bette_nicka@cox.net'), 
    ('Veronika', 'Inouye', '6 Greenleaf Ave', 'San Jose', 'CA', '95111', '408-540-1785', '408-813-4592', 'vinouye@aol.com'), 
    ('Willard', 'Kolmetz', '618 W Yakima Ave', 'Irving', 'TX', '75062', '972-303-9197', '972-896-4882', 'willard@hotmail.com'), 
    ('Maryann', 'Royster', '74 S Westgate St', 'Albany', 'NY', '12204', '518-966-7987', '518-448-8982', 'mroyster@royster.com'), 
    ('Alisha', 'Slusarski', '3273 State St', 'Middlesex', 'NJ', '8846', '732-658-3154', '732-635-3453', 'alisha@slusarski.com'), 
    ('Allene', 'Iturbide', '1 Central Ave', 'Stevens Point', 'WI', '54481', '715-662-6764', '715-530-9863', 'allene_iturbide@cox.net'), 
    ('Chanel', 'Caudy', '86 Nw 66th St Apt 8673', 'Shawnee', 'KS', '66218', '913-388-2079', '913-899-1103', 'chanel.caudy@caudy.org'), 
    ('Ezekiel', 'Chui', '2 Cedar Ave Apt 84', 'Easton', 'MD', '21601', '410-669-1642', '410-235-8738', 'ezekiel@chui.com'), 
    ('Willow', 'Kusko', '90991 Thorburn Ave', 'New York', 'NY', '10011', '212-582-4976', '212-934-5167', 'wkusko@yahoo.com'), 
    ('Bernardo', 'Figeroa', '386 9th Ave N', 'Conroe', 'TX', '77301', '936-336-3951', '936-597-3614', 'bfigeroa@aol.com'), 
    ('Ammie', 'Corrio', '74874 Atlantic Ave', 'Columbus', 'OH', '43215', '614-801-9788', '614-648-3265', 'ammie@corrio.com'), 
    ('Francine', 'Vocelka', '366 South Dr', 'Las Cruces', 'NM', '88011', '505-977-3911', '505-335-5293', 'francine_vocelka@vocelka.com'), 
    ('Ernie', 'Stenseth', '45 E Liberty St', 'Ridgefield Park', 'NJ', '7660', '201-709-6245', '201-387-9093', 'ernie_stenseth@aol.com'), 
    ('Albina', 'Glick', '4 Ralph Ct', 'Dunellen', 'NJ', '8812', '732-924-7882', '732-782-6701', 'albina@glick.com'), 
    ('Alishia', 'Sergi', '2742 Distribution Way', 'New York', 'NY', '10025', '212-860-1579', '212-753-2740', 'asergi@gmail.com'), 
    ('Solange', 'Shinko', '426 Wolf St', 'Metairie', 'LA', '70002', '504-979-9175', '504-265-8174', 'solange@shinko.com'), 
    ('Jose', 'Stockham', '128 Bransten Rd', 'New York', 'NY', '10011', '212-675-8570', '212-569-4233', 'jose@yahoo.com'), 
    ('Rozella', 'Ostrosky', '17 Morena Blvd', 'Camarillo', 'CA', '93012', '805-832-6163', '805-609-1531', 'rozella.ostrosky@ostrosky.com'), 
    ('Valentine', 'Gillian', '775 W 17th St', 'San Antonio', 'TX', '78204', '210-812-9597', '210-300-6244', 'valentine_gillian@gmail.com'), 
    ('Kati', 'Rulapaugh', '6980 Dorsett Rd', 'Abilene', 'KS', '67410', '785-463-7829', '785-219-7724', 'kati.rulapaugh@hotmail.com'), 
    ('Youlanda', 'Schemmer', '2881 Lewis Rd', 'Prineville', 'OR', '97754', '541-548-8197', '541-993-2611', 'youlanda@aol.com'), 
    ('Dyan', 'Oldroyd', '7219 Woodfield Rd', 'Overland Park', 'KS', '66204', '913-413-4604', '913-645-8918', 'doldroyd@aol.com'), 
    ('Roxane', 'Campain', '1048 Main St', 'Fairbanks', 'AK', '99708', '907-231-4722', '907-335-6568', 'roxane@hotmail.com'), 
    ('Lavera', 'Perin', '678 3rd Ave', 'Miami', 'FL', '33196', '305-606-7291', '305-995-2078', 'lperin@perin.org'), 
    ('Erick', 'Ferencz', '20 S Babcock St', 'Fairbanks', 'AK', '99712', '907-741-1044', '907-227-6777', 'erick.ferencz@aol.com'), 
    ('Fatima', 'Saylors', '2 Lighthouse Ave', 'Hopkins', 'MN', '55343', '952-768-2416', '952-479-2375', 'fsaylors@saylors.org'), 
    ('Jina', 'Briddick', '38938 Park Blvd', 'Boston', 'MA', '2128', '617-399-5124', '617-997-5771', 'jina_briddick@briddick.com'), 
    ('Kanisha', 'Waycott', '5 Tomahawk Dr', 'Los Angeles', 'CA', '90006', '323-453-2780', '323-315-7314', 'kanisha_waycott@yahoo.com'), 
    ('Emerson', 'Bowley', '762 S Main St', 'Madison', 'WI', '53711', '608-336-7444', '608-658-7940', 'emerson.bowley@bowley.org'), 
    ('Blair', 'Malet', '209 Decker Dr', 'Philadelphia', 'PA', '19132', '215-907-9111', '215-794-4519', 'bmalet@yahoo.com'), 
    ('Brock', 'Bolognia', '4486 W O St Apt 1', 'New York', 'NY', '10003', '212-402-9216', '212-617-5063', 'bbolognia@yahoo.com'), 
    ('Lorrie', 'Nestle', '39 S 7th St', 'Tullahoma', 'TN', '37388', '931-875-6644', '931-303-6041', 'lnestle@hotmail.com'), 
    ('Sabra', 'Uyetake', '98839 Hawthorne Blvd Apt 6101', 'Columbia', 'SC', '29201', '803-925-5213', '803-681-3678', 'sabra@uyetake.org'), 
    ('Marjory', 'Mastella', '71 San Mateo Ave', 'Wayne', 'PA', '19087', '610-814-5533', '610-379-7125', 'mmastella@mastella.com'), 
    ('Karl', 'Klonowski', '76 Brooks St Apt 9', 'Flemington', 'NJ', '8822', '908-877-6135', '908-470-4661', 'karl_klonowski@yahoo.com'), 
    ('Tonette', 'Wenner', '4545 Courthouse Rd', 'Westbury', 'NY', '11590', '516-968-6051', '516-333-4861', 'twenner@aol.com'), 
    ('Amber', 'Monarrez', '14288 Foster Ave Apt 4121', 'Jenkintown', 'PA', '19046', '215-934-8655', '215-329-6386', 'amber_monarrez@monarrez.org'), 
    ('Shenika', 'Seewald', '4 Otis St', 'Van Nuys', 'CA', '91405', '818-423-4007', '818-749-8650', 'shenika@gmail.com'), 
    ('Delmy', 'Ahle', '65895 S 16th St', 'Providence', 'RI', '2909', '401-458-2547', '401-559-8961', 'delmy.ahle@hotmail.com'), 
    ('Deeanna', 'Juhas', '14302 Pennsylvania Ave', 'Huntingdon Valley', 'PA', '19006', '215-211-9589', '215-417-9563', 'deeanna_juhas@gmail.com'), 
    ('Blondell', 'Pugh', '201 Hawk Ct', 'Providence', 'RI', '2904', '401-960-8259', '401-300-8122', 'bpugh@aol.com'), 
    ('Jamal', 'Vanausdal', '53075 Sw 152nd Ter Apt 615', 'Monroe Township', 'NJ', '8831', '732-234-1546', '732-904-2931', 'jamal@vanausdal.org'), 
    ('Cecily', 'Hollack', '59 N Groesbeck Hwy', 'Austin', 'TX', '78731', '512-486-3817', '512-861-3814', 'cecily@hollack.org'), 
    ('Carmelina', 'Lindall', '2664 Lewis Rd', 'Littleton', 'CO', '80126', '303-724-7371', '303-874-5160', 'carmelina_lindall@lindall.com'), 
    ('Maurine', 'Yglesias', '59 Shady Ln Apt 53', 'Milwaukee', 'WI', '53214', '414-748-1374', '414-573-7719', 'maurine_yglesias@yglesias.com'), 
    ('Tawna', 'Buvens', '3305 Nabell Ave Apt 679', 'New York', 'NY', '10009', '212-674-9610', '212-462-9157', 'tawna@gmail.com'), 
    ('Penney', 'Weight', '18 Fountain St', 'Anchorage', 'AK', '99515', '907-797-9628', '907-873-2882', 'penney_weight@aol.com'), 
    ('Elly', 'Morocco', '7 W 32nd St', 'Erie', 'PA', '16502', '814-393-5571', '814-420-3553', 'elly_morocco@gmail.com'), 
    ('Ilene', 'Eroman', '2853 S Central Expy', 'Glen Burnie', 'MD', '21061', '410-914-9018', '410-937-4543', 'ilene.eroman@hotmail.com'), 
    ('Vallie', 'Mondella', '74 W College St', 'Boise', 'ID', '83707', '208-862-5339', '208-737-8439', 'vmondella@mondella.com'), 
    ('Kallie', 'Blackwood', '701 S Harrison Rd', 'San Francisco', 'CA', '94104', '415-315-2761', '415-604-7609', 'kallie.blackwood@gmail.com'), 
    ('Johnetta', 'Abdallah', '1088 Pinehurst St', 'Chapel Hill', 'NC', '27514', '919-225-9345', '919-715-3791', 'johnetta_abdallah@aol.com'), 
    ('Bobbye', 'Rhym', '30 W 80th St Apt 1995', 'San Carlos', 'CA', '94070', '650-528-5783', '650-811-9032', 'brhym@rhym.com'), 
    ('Micaela', 'Rhymes', '20932 Hedley St', 'Concord', 'CA', '94520', '925-647-3298', '925-522-7798', 'micaela_rhymes@gmail.com'), 
    ('Tamar', 'Hoogland', '2737 Pistorio Rd Apt 9230', 'London', 'OH', '43140', '740-343-8575', '740-526-5410', 'tamar@hotmail.com'), 
    ('Moon', 'Parlato', '74989 Brandon St', 'Wellsville', 'NY', '14895', '585-866-8313', '585-498-4278', 'moon@yahoo.com'), 
    ('Laurel', 'Reitler', '6 Kains Ave', 'Baltimore', 'MD', '21215', '410-520-4832', '410-957-6903', 'laurel_reitler@reitler.com'), 
    ('Delisa', 'Crupi', '47565 W Grand Ave', 'Newark', 'NJ', '7105', '973-354-2040', '973-847-9611', 'delisa.crupi@crupi.com'), 
    ('Viva', 'Toelkes', '4284 Dorigo Ln', 'Chicago', 'IL', '60647', '773-446-5569', '773-352-3437', 'viva.toelkes@gmail.com'), 
    ('Elza', 'Lipke', '6794 Lake Dr E', 'Newark', 'NJ', '7104', '973-927-3447', '973-796-3667', 'elza@yahoo.com'), 
    ('Devorah', 'Chickering', '31 Douglas Blvd Apt 950', 'Clovis', 'NM', '88101', '505-975-8559', '505-950-1763', 'devorah@hotmail.com'), 
    ('Timothy', 'Mulqueen', '44 W 4th St', 'Staten Island', 'NY', '10309', '718-332-6527', '718-654-7063', 'timothy_mulqueen@mulqueen.org'), 
    ('Arlette', 'Honeywell', '11279 Loytan St', 'Jacksonville', 'FL', '32254', '904-775-4480', '904-514-9918', 'ahoneywell@honeywell.com'), 
    ('Dominque', 'Dickerson', '69 Marquette Ave', 'Hayward', 'CA', '94545', '510-993-3758', '510-901-7640', 'dominque.dickerson@dickerson.org'), 
    ('Lettie', 'Isenhower', '70 W Main St', 'Beachwood', 'OH', '44122', '216-657-7668', '216-733-8494', 'lettie_isenhower@yahoo.com'), 
    ('Myra', 'Munns', '461 Prospect Pl Apt 316', 'Euless', 'TX', '76040', '817-914-7518', '817-451-3518', 'mmunns@cox.net'), 
    ('Stephaine', 'Barfield', '47154 Whipple Ave Nw', 'Gardena', 'CA', '90247', '310-774-7643', '310-968-1219', 'stephaine@barfield.com'), 
    ('Lai', 'Gato', '37 Alabama Ave', 'Evanston', 'IL', '60201', '847-728-7286', '847-957-4614', 'lai.gato@gato.org'), 
    ('Stephen', 'Emigh', '3777 E Richmond St Apt 900', 'Akron', 'OH', '44302', '330-537-5358', '330-700-2312', 'stephen_emigh@hotmail.com'), 
    ('Tyra', 'Shields', '3 Fort Worth Ave', 'Philadelphia', 'PA', '19106', '215-255-1641', '215-228-8264', 'tshields@gmail.com'), 
    ('Tammara', 'Wardrip', '4800 Black Horse Pike', 'Burlingame', 'CA', '94010', '650-803-1936', '650-216-5075', 'twardrip@cox.net'), 
    ('Cory', 'Gibes', '83649 W Belmont Ave', 'San Gabriel', 'CA', '91776', '626-572-1096', '626-696-2777', 'cory.gibes@gmail.com'), 
    ('Danica', 'Bruschke', '840 15th Ave', 'Waco', 'TX', '76708', '254-782-8569', '254-205-1422', 'danica_bruschke@gmail.com'), 
    ('Wilda', 'Giguere', '1747 Calle Amanecer Apt 2', 'Anchorage', 'AK', '99501', '907-870-5536', '907-914-9482', 'wilda@cox.net'), 
    ('Elvera', 'Benimadho', '99385 Charity St Apt 840', 'San Jose', 'CA', '95110', '408-703-8505', '408-440-8447', 'elvera.benimadho@cox.net'), 
    ('Carma', 'Vanheusen', '68556 Central Hwy', 'San Leandro', 'CA', '94577', '510-503-7169', '510-452-4835', 'carma@cox.net'), 
    ('Malinda', 'Hochard', '55 Riverside Ave', 'Indianapolis', 'IN', '46202', '317-722-5066', '317-472-2412', 'malinda.hochard@yahoo.com'), 
    ('Natalie', 'Fern', '7140 University Ave', 'Rock Springs', 'WY', '82901', '307-704-8713', '307-279-3793', 'natalie.fern@hotmail.com'), 
    ('Lisha', 'Centini', '64 5th Ave Apt 1153', 'Mc Lean', 'VA', '22102', '703-235-3937', '703-475-7568', 'lisha@centini.org'), 
    ('Arlene', 'Klusman', '3 Secor Rd', 'New Orleans', 'LA', '70112', '504-710-5840', '504-946-1807', 'arlene_klusman@gmail.com'), 
    ('Alease', 'Buemi', '4 Webbs Chapel Rd', 'Boulder', 'CO', '80303', '303-301-4946', '303-521-9860', 'alease@buemi.com'), 
    ('Louisa', 'Cronauer', '524 Louisiana Ave Nw', 'San Leandro', 'CA', '94577', '510-828-7047', '510-472-7758', 'louisa@cronauer.com'), 
    ('Angella', 'Cetta', '185 Blackstone Bldge', 'Honolulu', 'HI', '96817', '808-892-7943', '808-475-2310', 'angella.cetta@hotmail.com'), 
    ('Cyndy', 'Goldammer', '170 Wyoming Ave', 'Burnsville', 'MN', '55337', '952-334-9408', '952-938-9457', 'cgoldammer@cox.net'), 
    ('Rosio', 'Cork', '4 10th St W', 'High Point', 'NC', '27263', '336-243-5659', '336-497-4407', 'rosio.cork@gmail.com'), 
    ('Celeste', 'Korando', '7 W Pinhook Rd', 'Lynbrook', 'NY', '11563', '516-509-2347', '516-365-7266', 'ckorando@hotmail.com'), 
    ('Twana', 'Felger', '1 Commerce Way', 'Portland', 'OR', '97224', '503-939-3153', '503-909-7167', 'twana.felger@felger.org'), 
    ('Estrella', 'Samu', '64 Lakeview Ave', 'Beloit', 'WI', '53511', '608-976-7199', '608-942-8836', 'estrella@aol.com'), 
    ('Donte', 'Kines', '3 Aspen St', 'Worcester', 'MA', '1602', '508-429-8576', '508-843-1426', 'dkines@hotmail.com'), 
    ('Tiffiny', 'Steffensmeier', '32860 Sierra Rd', 'Miami', 'FL', '33133', '305-385-9695', '305-304-6573', 'tiffiny_steffensmeier@cox.net'), 
    ('Edna', 'Miceli', '555 Main St', 'Erie', 'PA', '16502', '814-460-2655', '814-299-2877', 'emiceli@miceli.org'), 
    ('Sue', 'Kownacki', '2 Se 3rd Ave', 'Mesquite', 'TX', '75149', '972-666-3413', '972-742-4000', 'sue@aol.com'), 
    ('Jesusa', 'Shin', '2239 Shawnee Mission Pky', 'Tullahoma', 'TN', '37388', '931-273-8709', '931-739-1551', 'jshin@shin.com'), 
    ('Rolland', 'Francescon', '2726 Charcot Ave', 'Paterson', 'NJ', '7501', '973-649-2922', '973-284-4048', 'rolland@cox.net'), 
    ('Pamella', 'Schmierer', '5161 Dorsett Rd', 'Homestead', 'FL', '33030', '305-420-8970', '305-575-8481', 'pamella.schmierer@schmierer.org'), 
    ('Glory', 'Kulzer', '55892 Jacksonville Rd', 'Owings Mills', 'MD', '21117', '410-224-9462', '410-916-8015', 'gkulzer@kulzer.org'), 
    ('Shawna', 'Palaspas', '5 N Cleveland Massillon Rd', 'Thousand Oaks', 'CA', '91362', '805-275-3566', '805-638-6617', 'shawna_palaspas@palaspas.org'), 
    ('Brandon', 'Callaro', '7 Benton Dr', 'Honolulu', 'HI', '96819', '808-215-6832', '808-240-5168', 'brandon_callaro@hotmail.com'), 
    ('Scarlet', 'Cartan', '9390 S Howell Ave', 'Albany', 'GA', '31701', '229-735-3378', '229-365-9658', 'scarlet.cartan@yahoo.com'), 
    ('Oretha', 'Menter', '8 County Center Dr Apt 647', 'Boston', 'MA', '2210', '617-418-5043', '617-697-6024', 'oretha_menter@yahoo.com'), 
    ('Ty', 'Smith', '4646 Kaahumanu St', 'Hackensack', 'NJ', '7601', '201-672-1553', '201-995-3149', 'tsmith@aol.com'), 
    ('Xuan', 'Rochin', '2 Monroe St', 'San Mateo', 'CA', '94403', '650-933-5072', '650-247-2625', 'xuan@gmail.com'), 
    ('Lindsey', 'Dilello', '52777 Leaders Heights Rd', 'Ontario', 'CA', '91761', '909-639-9887', '909-589-1693', 'lindsey.dilello@hotmail.com'), 
    ('Devora', 'Perez', '72868 Blackington Ave', 'Oakland', 'CA', '94606', '510-955-3016', '510-755-9274', 'devora_perez@perez.org'), 
    ('Herman', 'Demesa', '9 Norristown Rd', 'Troy', 'NY', '12180', '518-497-2940', '518-931-7852', 'hdemesa@cox.net'), 
    ('Rory', 'Papasergi', '83 County Road 437 Apt 8581', 'Clarks Summit', 'PA', '18411', '570-867-7489', '570-469-8401', 'rpapasergi@cox.net'), 
    ('Talia', 'Riopelle', '1 N Harlem Ave Apt 9', 'Orange', 'NJ', '7050', '973-245-2133', '973-818-9788', 'talia_riopelle@aol.com'), 
    ('Van', 'Shire', '90131 J St', 'Pittstown', 'NJ', '8867', '908-409-2890', '908-448-1209', 'van.shire@shire.com'), 
    ('Lucina', 'Lary', '8597 W National Ave', 'Cocoa', 'FL', '32922', '321-749-4981', '321-632-4668', 'lucina_lary@cox.net'), 
    ('Bok', 'Isaacs', '6 Gilson St', 'Bronx', 'NY', '10468', '718-809-3762', '718-478-8568', 'bok.isaacs@aol.com'), 
    ('Rolande', 'Spickerman', '65 W Maple Ave', 'Pearl City', 'HI', '96782', '808-315-3077', '808-526-5863', 'rolande.spickerman@spickerman.com'), 
    ('Howard', 'Paulas', '866 34th Ave', 'Denver', 'CO', '80231', '303-623-4241', '303-692-3118', 'hpaulas@gmail.com'), 
    ('Kimbery', 'Madarang', '798 Lund Farm Way', 'Rockaway', 'NJ', '7866', '973-310-1634', '973-225-6259', 'kimbery_madarang@cox.net'), 
    ('Thurman', 'Manno', '9387 Charcot Ave', 'Absecon', 'NJ', '8201', '609-524-3586', '609-234-8376', 'thurman.manno@yahoo.com'), 
    ('Becky', 'Mirafuentes', '30553 Washington Rd', 'Plainfield', 'NJ', '7062', '908-877-8409', '908-426-8272', 'becky.mirafuentes@mirafuentes.com'), 
    ('Beatriz', 'Corrington', '481 W Lemon St', 'Middleboro', 'MA', '2346', '508-584-4279', '508-315-3867', 'beatriz@yahoo.com'), 
    ('Marti', 'Maybury', '4 Warehouse Point Rd Apt 7', 'Chicago', 'IL', '60638', '773-775-4522', '773-539-1058', 'marti.maybury@yahoo.com'), 
    ('Nieves', 'Gotter', '4940 Pulaski Park Dr', 'Portland', 'OR', '97202', '503-527-5274', '503-455-3094', 'nieves_gotter@gmail.com'), 
    ('Leatha', 'Hagele', '627 Walford Ave', 'Dallas', 'TX', '75227', '214-339-1809', '214-225-5850', 'lhagele@cox.net'), 
    ('Valentin', 'Klimek', '137 Pioneer Way', 'Chicago', 'IL', '60604', '312-303-5453', '312-512-2338', 'vklimek@klimek.org'), 
    ('Melissa', 'Wiklund', '61 13 Stoneridge Apt 835', 'Findlay', 'OH', '45840', '419-939-3613', '419-254-4591', 'melissa@cox.net'), 
    ('Sheridan', 'Zane', '2409 Alabama Rd', 'Riverside', 'CA', '92501', '951-645-3605', '951-248-6822', 'sheridan.zane@zane.com'), 
    ('Bulah', 'Padilla', '8927 Vandever Ave', 'Waco', 'TX', '76707', '254-463-4368', '254-816-8417', 'bulah_padilla@hotmail.com'), 
    ('Audra', 'Kohnert', '134 Lewis Rd', 'Nashville', 'TN', '37211', '615-406-7854', '615-448-9249', 'audra@kohnert.com'), 
    ('Daren', 'Weirather', '9 N College Ave Apt 3', 'Milwaukee', 'WI', '53216', '414-959-2540', '414-838-3151', 'dweirather@aol.com'), 
    ('Fernanda', 'Jillson', '60480 Old Us Highway 51', 'Preston', 'MD', '21655', '410-387-5260', '410-724-6472', 'fjillson@aol.com'), 
    ('Gearldine', 'Gellinger', '4 Bloomfield Ave', 'Irving', 'TX', '75061', '972-934-6914', '972-821-7118', 'gearldine_gellinger@gellinger.com'), 
    ('Chau', 'Kitzman', '429 Tiger Ln', 'Beverly Hills', 'CA', '90212', '310-560-8022', '310-969-7230', 'chau@gmail.com'), 
    ('Theola', 'Frey', '54169 N Main St', 'Massapequa', 'NY', '11758', '516-948-5768', '516-357-3362', 'theola_frey@frey.com'), 
    ('Cheryl', 'Haroldson', '92 Main St', 'Atlantic City', 'NJ', '8401', '609-518-7697', '609-263-9243', 'cheryl@haroldson.org'), 
    ('Laticia', 'Merced', '72 Mannix Dr', 'Cincinnati', 'OH', '45203', '513-508-7371', '513-418-1566', 'lmerced@gmail.com'), 
    ('Carissa', 'Batman', '12270 Caton Center Dr', 'Eugene', 'OR', '97401', '541-326-4074', '541-801-5717', 'carissa.batman@yahoo.com'), 
    ('Lezlie', 'Craghead', '749 W 18th St Apt 45', 'Smithfield', 'NC', '27577', '919-533-3762', '919-885-2453', 'lezlie.craghead@craghead.org'), 
    ('Ozell', 'Shealy', '8 Industry Ln', 'New York', 'NY', '10002', '212-332-8435', '212-880-8865', 'oshealy@hotmail.com'), 
    ('Arminda', 'Parvis', '1 Huntwood Ave', 'Phoenix', 'AZ', '85017', '602-906-9419', '602-277-3025', 'arminda@parvis.com'), 
    ('Reita', 'Leto', '55262 N French Rd', 'Indianapolis', 'IN', '46240', '317-234-1135', '317-787-5514', 'reita.leto@gmail.com'), 
    ('Yolando', 'Luczki', '422 E 21st St', 'Syracuse', 'NY', '13214', '315-304-4759', '315-640-6357', 'yolando@cox.net'), 
    ('Lizette', 'Stem', '501 N 19th Ave', 'Cherry Hill', 'NJ', '8002', '856-487-5412', '856-702-3676', 'lizette.stem@aol.com'), 
    ('Gregoria', 'Pawlowicz', '455 N Main Ave', 'Garden City', 'NY', '11530', '516-212-1915', '516-376-4230', 'gpawlowicz@yahoo.com'), 
    ('Carin', 'Deleo', '1844 Southern Blvd', 'Little Rock', 'AR', '72202', '501-308-1040', '501-409-6072', 'cdeleo@deleo.com'), 
    ('Chantell', 'Maynerich', '2023 Greg St', 'Saint Paul', 'MN', '55101', '651-591-2583', '651-776-9688', 'chantell@yahoo.com'), 
    ('Dierdre', 'Yum', '63381 Jenks Ave', 'Philadelphia', 'PA', '19134', '215-325-3042', '215-346-4666', 'dyum@yahoo.com'), 
    ('Larae', 'Gudroe', '6651 Municipal Rd', 'Houma', 'LA', '70360', '985-890-7262', '985-261-5783', 'larae_gudroe@gmail.com'), 
    ('Latrice', 'Tolfree', '81 Norris Ave Apt 525', 'Ronkonkoma', 'NY', '11779', '631-957-7624', '631-998-2102', 'latrice.tolfree@hotmail.com'), 
    ('Kerry', 'Theodorov', '6916 W Main St', 'Sacramento', 'CA', '95827', '916-591-3277', '916-770-7448', 'kerry.theodorov@gmail.com'), 
    ('Dorthy', 'Hidvegi', '9635 S Main St', 'Boise', 'ID', '83704', '208-649-2373', '208-690-3315', 'dhidvegi@yahoo.com'), 
    ('Fannie', 'Lungren', '17 Us Highway 111', 'Round Rock', 'TX', '78664', '512-587-5746', '512-528-9933', 'fannie.lungren@yahoo.com'), 
    ('Evangelina', 'Radde', '992 Civic Center Dr', 'Philadelphia', 'PA', '19123', '215-964-3284', '215-417-5612', 'evangelina@aol.com'), 
    ('Novella', 'Degroot', '303 N Radcliffe St', 'Hilo', 'HI', '96720', '808-477-4775', '808-746-1865', 'novella_degroot@degroot.org'), 
    ('Clay', 'Hoa', '73 Saint Ann St Apt 86', 'Reno', 'NV', '89502', '775-501-8109', '775-848-9135', 'choa@hoa.org'), 
    ('Jennifer', 'Fallick', '44 58th St', 'Wheeling', 'IL', '60090', '847-979-9545', '847-800-3054', 'jfallick@yahoo.com'), 
    ('Irma', 'Wolfgramm', '9745 W Main St', 'Randolph', 'NJ', '7869', '973-545-7355', '973-868-8660', 'irma.wolfgramm@hotmail.com'), 
    ('Eun', 'Coody', '84 Bloomfield Ave', 'Spartanburg', 'SC', '29301', '864-256-3620', '864-594-4578', 'eun@yahoo.com'), 
    ('Sylvia', 'Cousey', '287 Youngstown Warren Rd', 'Hampstead', 'MD', '21074', '410-209-9545', '410-863-8263', 'sylvia_cousey@cousey.org'), 
    ('Nana', 'Wrinkles', '6 Van Buren St', 'Mount Vernon', 'NY', '10553', '914-855-2115', '914-796-3775', 'nana@aol.com'), 
    ('Layla', 'Springe', '229 N Forty Driv', 'New York', 'NY', '10011', '212-260-3151', '212-253-7448', 'layla.springe@cox.net'), 
    ('Joesph', 'Degonia', '2887 Knowlton St Apt 5435', 'Berkeley', 'CA', '94710', '510-677-9785', '510-942-5916', 'joesph_degonia@degonia.org'), 
    ('Annabelle', 'Boord', '523 Marquette Ave', 'Concord', 'MA', '1742', '978-697-6263', '978-289-7717', 'annabelle.boord@cox.net'), 
    ('Stephaine', 'Vinning', '3717 Hamann Industrial Pky', 'San Francisco', 'CA', '94104', '415-767-6596', '415-712-9530', 'stephaine@cox.net'), 
    ('Nelida', 'Sawchuk', '3 State Route 35 S', 'Paramus', 'NJ', '7652', '201-971-1638', '201-247-8925', 'nelida@gmail.com'), 
    ('Marguerita', 'Hiatt', '82 N Highway 67', 'Oakley', 'CA', '94561', '925-634-7158', '925-541-8521', 'marguerita.hiatt@gmail.com'), 
    ('Carmela', 'Cookey', '9 Murfreesboro Rd', 'Chicago', 'IL', '60623', '773-494-4195', '773-297-9391', 'ccookey@cookey.org'), 
    ('Junita', 'Brideau', '6 S Broadway St', 'Cedar Grove', 'NJ', '7009', '973-943-3423', '973-582-5469', 'jbrideau@aol.com'), 
    ('Claribel', 'Varriano', '6 Harry L Dr Apt 6327', 'Perrysburg', 'OH', '43551', '419-544-4900', '419-573-2033', 'claribel_varriano@cox.net'), 
    ('Benton', 'Skursky', '47939 Porter Ave', 'Gardena', 'CA', '90248', '310-579-2907', '310-694-8466', 'benton.skursky@aol.com'), 
    ('Hillary', 'Skulski', '9 Wales Rd Ne Apt 914', 'Homosassa', 'FL', '34448', '352-242-2570', '352-990-5946', 'hillary.skulski@aol.com'), 
    ('Merilyn', 'Bayless', '195 13n N', 'Santa Clara', 'CA', '95054', '408-758-5015', '408-346-2180', 'merilyn_bayless@cox.net'), 
    ('Teri', 'Ennaco', '99 Tank Farm Rd', 'Hazleton', 'PA', '18201', '570-889-5187', '570-355-1665', 'tennaco@gmail.com'), 
    ('Merlyn', 'Lawler', '4671 Alemany Blvd', 'Jersey City', 'NJ', '7304', '201-588-7810', '201-858-9960', 'merlyn_lawler@hotmail.com'), 
    ('Georgene', 'Montezuma', '98 University Dr', 'San Ramon', 'CA', '94583', '925-615-5185', '925-943-3449', 'gmontezuma@cox.net'), 
    ('Jettie', 'Mconnell', '50 E Wacker Dr', 'Bridgewater', 'NJ', '8807', '908-802-3564', '908-602-5258', 'jmconnell@hotmail.com'), 
    ('Lemuel', 'Latzke', '70 Euclid Ave Apt 722', 'Bohemia', 'NY', '11716', '631-748-6479', '631-291-4976', 'lemuel.latzke@gmail.com'), 
    ('Melodie', 'Knipp', '326 E Main St Apt 6496', 'Thousand Oaks', 'CA', '91362', '805-690-1682', '805-810-8964', 'mknipp@gmail.com'), 
    ('Candida', 'Corbley', '406 Main St', 'Somerville', 'NJ', '8876', '908-275-8357', '908-943-6103', 'candida_corbley@hotmail.com'), 
    ('Karan', 'Karpin', '3 Elmwood Dr', 'Beaverton', 'OR', '97005', '503-940-8327', '503-707-5812', 'karan_karpin@gmail.com'), 
    ('Andra', 'Scheyer', '9 Church St', 'Salem', 'OR', '97302', '503-516-2189', '503-950-3068', 'andra@gmail.com'), 
    ('Felicidad', 'Poullion', '9939 N 14th St', 'Riverton', 'NJ', '8077', '856-305-9731', '856-828-6021', 'fpoullion@poullion.com'), 
    ('Belen', 'Strassner', '5384 Southwyck Blvd', 'Douglasville', 'GA', '30135', '770-507-8791', '770-802-4003', 'belen_strassner@aol.com'), 
    ('Gracia', 'Melnyk', '97 Airport Loop Dr', 'Jacksonville', 'FL', '32216', '904-235-3633', '904-627-4341', 'gracia@melnyk.com'), 
    ('Jolanda', 'Hanafan', '37855 Nolan Rd', 'Bangor', 'ME', '4401', '207-458-9196', '207-233-6185', 'jhanafan@gmail.com'), 
    ('Barrett', 'Toyama', '4252 N Washington Ave Apt 9', 'Kennedale', 'TX', '76060', '817-765-5781', '817-577-6151', 'barrett.toyama@toyama.org'), 
    ('Helga', 'Fredicks', '42754 S Ash Ave', 'Buffalo', 'NY', '14228', '716-752-4114', '716-854-9845', 'helga_fredicks@yahoo.com'), 
    ('Ashlyn', 'Pinilla', '703 Beville Rd', 'Opa Locka', 'FL', '33054', '305-670-9628', '305-857-5489', 'apinilla@cox.net'), 
    ('Fausto', 'Agramonte', '5 Harrison Rd', 'New York', 'NY', '10038', '212-313-1783', '212-778-3063', 'fausto_agramonte@yahoo.com'), 
    ('Ronny', 'Caiafa', '73 Southern Blvd', 'Philadelphia', 'PA', '19103', '215-605-7570', '215-511-3531', 'ronny.caiafa@caiafa.org'), 
    ('Marge', 'Limmel', '189 Village Park Rd', 'Crestview', 'FL', '32536', '850-430-1663', '850-330-8079', 'marge@gmail.com'), 
    ('Norah', 'Waymire', '6 Middlegate Rd Apt 106', 'San Francisco', 'CA', '94107', '415-306-7897', '415-874-2984', 'norah.waymire@gmail.com'), 
    ('Aliza', 'Baltimore', '1128 Delaware St', 'San Jose', 'CA', '95132', '408-504-3552', '408-425-1994', 'aliza@aol.com'), 
    ('Mozell', 'Pelkowski', '577 Parade St', 'South San Francisco', 'CA', '94080', '650-947-1215', '650-960-1069', 'mpelkowski@pelkowski.org'), 
    ('Viola', 'Bitsuie', '70 Mechanic St', 'Northridge', 'CA', '91325', '818-864-4875', '818-481-5787', 'viola@gmail.com'), 
    ('Franklyn', 'Emard', '4379 Highway 116', 'Philadelphia', 'PA', '19103', '215-558-8189', '215-483-3003', 'femard@emard.com'), 
    ('Willodean', 'Konopacki', '55 Hawthorne Blvd', 'Lafayette', 'LA', '70506', '337-253-8384', '337-774-7564', 'willodean_konopacki@konopacki.org'), 
    ('Beckie', 'Silvestrini', '7116 Western Ave', 'Dearborn', 'MI', '48126', '313-533-4884', '313-390-7855', 'beckie.silvestrini@silvestrini.com'), 
    ('Rebecka', 'Gesick', '2026 N Plankinton Ave Apt 3', 'Austin', 'TX', '78754', '512-213-8574', '512-693-8345', 'rgesick@gesick.org'), 
    ('Frederica', 'Blunk', '99586 Main St', 'Dallas', 'TX', '75207', '214-428-2285', '214-529-1949', 'frederica_blunk@gmail.com'), 
    ('Glen', 'Bartolet', '8739 Hudson St', 'Vashon', 'WA', '98070', '206-697-5796', '206-389-1482', 'glen_bartolet@hotmail.com'), 
    ('Freeman', 'Gochal', '383 Gunderman Rd Apt 197', 'Coatesville', 'PA', '19320', '610-476-3501', '610-752-2683', 'freeman_gochal@aol.com'), 
    ('Vincent', 'Meinerding', '4441 Point Term Mkt', 'Philadelphia', 'PA', '19143', '215-372-1718', '215-829-4221', 'vincent.meinerding@hotmail.com'), 
    ('Rima', 'Bevelacqua', '2972 Lafayette Ave', 'Gardena', 'CA', '90248', '310-858-5079', '310-499-4200', 'rima@cox.net'), 
    ('Glendora', 'Sarbacher', '2140 Diamond Blvd', 'Rohnert Park', 'CA', '94928', '707-653-8214', '707-881-3154', 'gsarbacher@gmail.com'), 
    ('Avery', 'Steier', '93 Redmond Rd Apt 492', 'Orlando', 'FL', '32803', '407-808-9439', '407-945-8566', 'avery@cox.net'), 
    ('Cristy', 'Lother', '3989 Portage Tr', 'Escondido', 'CA', '92025', '760-971-4322', '760-465-4762', 'cristy@lother.com'), 
    ('Nicolette', 'Brossart', '1 Midway Rd', 'Westborough', 'MA', '1581', '508-837-9230', '508-504-6388', 'nicolette_brossart@brossart.com'), 
    ('Tracey', 'Modzelewski', '77132 Coon Rapids Blvd Nw', 'Conroe', 'TX', '77301', '936-264-9294', '936-988-8171', 'tracey@hotmail.com'), 
    ('Virgina', 'Tegarden', '755 Harbor Way', 'Milwaukee', 'WI', '53226', '414-214-8697', '414-411-5744', 'virgina_tegarden@tegarden.com'), 
    ('Tiera', 'Frankel', '87 Sierra Rd', 'El Monte', 'CA', '91731', '626-636-4117', '626-638-4241', 'tfrankel@aol.com'), 
    ('Alaine', 'Bergesen', '7667 S Hulen St Apt 42', 'Yonkers', 'NY', '10701', '914-300-9193', '914-654-1426', 'alaine_bergesen@cox.net'), 
    ('Earleen', 'Mai', '75684 S Withlapopka Dr Apt 32', 'Dallas', 'TX', '75227', '214-289-1973', '214-785-6750', 'earleen_mai@cox.net'), 
    ('Leonida', 'Gobern', '5 Elmwood Park Blvd', 'Biloxi', 'MS', '39530', '228-235-5615', '228-432-4635', 'leonida@gobern.org'), 
    ('Ressie', 'Auffrey', '23 Palo Alto Sq', 'Miami', 'FL', '33134', '305-604-8981', '305-287-4743', 'ressie.auffrey@yahoo.com'), 
    ('Justine', 'Mugnolo', '38062 E Main St', 'New York', 'NY', '10048', '212-304-9225', '212-311-6377', 'jmugnolo@yahoo.com'), 
    ('Eladia', 'Saulter', '3958 S Dupont Hwy Apt 7', 'Ramsey', 'NJ', '7446', '201-474-4924', '201-365-8698', 'eladia@saulter.com'), 
    ('Chaya', 'Malvin', '560 Civic Center Dr', 'Ann Arbor', 'MI', '48103', '734-928-5182', '734-408-8174', 'chaya@malvin.com'), 
    ('Gwenn', 'Suffield', '3270 Dequindre Rd', 'Deer Park', 'NY', '11729', '631-258-6558', '631-295-9879', 'gwenn_suffield@suffield.org'), 
    ('Salena', 'Karpel', '1 Garfield Ave Apt 7', 'Canton', 'OH', '44707', '330-791-8557', '330-618-2579', 'skarpel@cox.net'), 
    ('Yoko', 'Fishburne', '9122 Carpenter Ave', 'New Haven', 'CT', '6511', '203-506-4706', '203-840-8634', 'yoko@fishburne.com'), 
    ('Taryn', 'Moyd', '48 Lenox St', 'Fairfax', 'VA', '22030', '703-322-4041', '703-938-7939', 'taryn.moyd@hotmail.com'), 
    ('Katina', 'Polidori', '5 Little River Tpke', 'Wilmington', 'MA', '1887', '978-626-2978', '978-679-7429', 'katina_polidori@aol.com'), 
    ('Rickie', 'Plumer', '3 N Groesbeck Hwy', 'Toledo', 'OH', '43613', '419-693-1334', '419-313-5571', 'rickie.plumer@aol.com'), 
    ('Alex', 'Loader', '37 N Elm St Apt 916', 'Tacoma', 'WA', '98409', '253-660-7821', '253-875-9222', 'alex@loader.com'), 
    ('Lashon', 'Vizarro', '433 Westminster Blvd Apt 590', 'Roseville', 'CA', '95661', '916-741-7884', '916-289-4526', 'lashon@aol.com'), 
    ('Lauran', 'Burnard', '66697 Park Pl Apt 3224', 'Riverton', 'WY', '82501', '307-342-7795', '307-453-7589', 'lburnard@burnard.com'), 
    ('Ceola', 'Setter', '96263 Greenwood Pl', 'Warren', 'ME', '4864', '207-627-7565', '207-297-5029', 'ceola.setter@setter.org'), 
    ('My', 'Rantanen', '8 Mcarthur Ln', 'Richboro', 'PA', '18954', '215-491-5633', '215-647-2158', 'my@hotmail.com'), 
    ('Lorrine', 'Worlds', '8 Fair Lawn Ave', 'Tampa', 'FL', '33614', '813-769-2939', '813-863-6467', 'lorrine.worlds@worlds.com'), 
    ('Peggie', 'Sturiale', '9 N 14th St', 'El Cajon', 'CA', '92020', '619-608-1763', '619-695-8086', 'peggie@cox.net'), 
    ('Marvel', 'Raymo', '9 Vanowen St', 'College Station', 'TX', '77840', '979-718-8968', '979-809-5770', 'mraymo@yahoo.com'), 
    ('Daron', 'Dinos', '18 Waterloo Geneva Rd', 'Highland Park', 'IL', '60035', '847-233-3075', '847-265-6609', 'daron_dinos@cox.net'), 
    ('An', 'Fritz', '506 S Hacienda Dr', 'Atlantic City', 'NJ', '8401', '609-228-5265', '609-854-7156', 'an_fritz@hotmail.com'), 
    ('Portia', 'Stimmel', '3732 Sherman Ave', 'Bridgewater', 'NJ', '8807', '908-722-7128', '908-670-4712', 'portia.stimmel@aol.com'), 
    ('Rhea', 'Aredondo', '25657 Live Oak St', 'Brooklyn', 'NY', '11226', '718-560-9537', '718-280-4183', 'rhea_aredondo@cox.net'), 
    ('Benedict', 'Sama', '4923 Carey Ave', 'Saint Louis', 'MO', '63104', '314-787-1588', '314-858-4832', 'bsama@cox.net'), 
    ('Alyce', 'Arias', '3196 S Rider Trl', 'Stockton', 'CA', '95207', '209-317-1801', '209-242-7022', 'alyce@arias.org'), 
    ('Heike', 'Berganza', '3 Railway Ave Apt 75', 'Little Falls', 'NJ', '7424', '973-936-5095', '973-822-8827', 'heike@gmail.com'), 
    ('Carey', 'Dopico', '87393 E Highland Rd', 'Indianapolis', 'IN', '46220', '317-578-2453', '317-441-5848', 'carey_dopico@dopico.org'), 
    ('Dottie', 'Hellickson', '67 E Chestnut Hill Rd', 'Seattle', 'WA', '98133', '206-540-6076', '206-295-5631', 'dottie@hellickson.org'), 
    ('Deandrea', 'Hughey', '33 Lewis Rd Apt 46', 'Burlington', 'NC', '27215', '336-822-7652', '336-467-3095', 'deandrea@yahoo.com'), 
    ('Kimberlie', 'Duenas', '8100 Jacksonville Rd Apt 7', 'Hays', 'KS', '67601', '785-629-8542', '785-616-1685', 'kimberlie_duenas@yahoo.com'), 
    ('Martina', 'Staback', '7 W Wabansia Ave Apt 227', 'Orlando', 'FL', '32822', '407-471-6908', '407-429-2145', 'martina_staback@staback.com'), 
    ('Skye', 'Fillingim', '25 Minters Chapel Rd Apt 9', 'Minneapolis', 'MN', '55401', '612-508-2655', '612-664-6304', 'skye_fillingim@yahoo.com'), 
    ('Jade', 'Farrar', '6882 Torresdale Ave', 'Columbia', 'SC', '29201', '803-352-5387', '803-975-3405', 'jade.farrar@yahoo.com'), 
    ('Charlene', 'Hamilton', '985 E 6th Ave', 'Santa Rosa', 'CA', '95407', '707-300-1771', '707-821-8037', 'charlene.hamilton@hotmail.com'), 
    ('Geoffrey', 'Acey', '7 West Ave Apt 1', 'Palatine', 'IL', '60067', '847-222-1734', '847-556-2909', 'geoffrey@gmail.com'), 
    ('Stevie', 'Westerbeck', '26659 N 13th St', 'Costa Mesa', 'CA', '92626', '949-867-4077', '949-903-3898', 'stevie.westerbeck@yahoo.com'), 
    ('Pamella', 'Fortino', '669 Packerland Dr Apt 1438', 'Denver', 'CO', '80212', '303-404-2210', '303-794-1341', 'pamella@fortino.com'), 
    ('Harrison', 'Haufler', '759 Eldora St', 'New Haven', 'CT', '6515', '203-801-6193', '203-801-8497', 'hhaufler@hotmail.com'), 
    ('Johnna', 'Engelberg', '5 S Colorado Blvd Apt 449', 'Bothell', 'WA', '98021', '425-986-7573', '425-700-3751', 'jengelberg@engelberg.org'), 
    ('Buddy', 'Cloney', '944 Gaither Dr', 'Strongsville', 'OH', '44136', '440-989-5826', '440-327-2093', 'buddy.cloney@yahoo.com'), 
    ('Dalene', 'Riden', '66552 Malone Rd', 'Plaistow', 'NH', '3865', '603-315-6839', '603-745-7497', 'dalene.riden@aol.com'), 
    ('Jerry', 'Zurcher', '77 Massillon Rd Apt 822', 'Satellite Beach', 'FL', '32937', '321-518-5938', '321-597-2159', 'jzurcher@zurcher.org'), 
    ('Haydee', 'Denooyer', '25346 New Rd', 'New York', 'NY', '10016', '212-792-8658', '212-782-3493', 'hdenooyer@denooyer.org'), 
    ('Joseph', 'Cryer', '60 Fillmore Ave', 'Huntington Beach', 'CA', '92647', '714-584-2237', '714-698-2170', 'joseph_cryer@cox.net'), 
    ('Deonna', 'Kippley', '57 Haven Ave Apt 90', 'Southfield', 'MI', '48075', '248-913-4677', '248-793-4966', 'deonna_kippley@hotmail.com'), 
    ('Raymon', 'Calvaresi', '6538 E Pomona St Apt 60', 'Indianapolis', 'IN', '46222', '317-825-4724', '317-342-1532', 'raymon.calvaresi@gmail.com'), 
    ('Alecia', 'Bubash', '6535 Joyce St', 'Wichita Falls', 'TX', '76301', '940-276-7922', '940-302-3036', 'alecia@aol.com'), 
    ('Ma', 'Layous', '78112 Morris Ave', 'North Haven', 'CT', '6473', '203-721-3388', '203-564-1543', 'mlayous@hotmail.com'), 
    ('Detra', 'Coyier', '96950 Hidden Ln', 'Aberdeen', 'MD', '21001', '410-739-9277', '410-259-2118', 'detra@aol.com'), 
    ('Terrilyn', 'Rodeigues', '3718 S Main St', 'New Orleans', 'LA', '70130', '504-463-4384', '504-635-8518', 'terrilyn.rodeigues@cox.net'), 
    ('Salome', 'Lacovara', '9677 Commerce Dr', 'Richmond', 'VA', '23219', '804-550-5097', '804-858-1011', 'slacovara@gmail.com'), 
    ('Garry', 'Keetch', '5 Green Pond Rd Apt 4', 'Southampton', 'PA', '18966', '215-979-8776', '215-846-9046', 'garry_keetch@hotmail.com'), 
    ('Matthew', 'Neither', '636 Commerce Dr Apt 42', 'Shakopee', 'MN', '55379', '952-651-7597', '952-906-4597', 'mneither@yahoo.com'), 
    ('Theodora', 'Restrepo', '42744 Hamann Industrial Pky Apt 82', 'Miami', 'FL', '33136', '305-936-8226', '305-573-1085', 'theodora.restrepo@restrepo.com'), 
    ('Noah', 'Kalafatis', '1950 5th Ave', 'Milwaukee', 'WI', '53209', '414-263-5287', '414-660-9766', 'noah.kalafatis@aol.com'), 
    ('Carmen', 'Sweigard', '61304 N French Rd', 'Somerset', 'NJ', '8873', '732-941-2621', '732-445-6940', 'csweigard@sweigard.com'), 
    ('Lavonda', 'Hengel', '87 Imperial Ct Apt 79', 'Fargo', 'ND', '58102', '701-898-2154', '701-421-7080', 'lavonda@cox.net'), 
    ('Junita', 'Stoltzman', '94 W Dodge Rd', 'Carson City', 'NV', '89701', '775-638-9963', '775-578-1214', 'junita@aol.com'), 
    ('Herminia', 'Nicolozakes', '4 58th St Apt 3519', 'Scottsdale', 'AZ', '85254', '602-954-5141', '602-304-6433', 'herminia@nicolozakes.org'), 
    ('Casie', 'Good', '5221 Bear Valley Rd', 'Nashville', 'TN', '37211', '615-390-2251', '615-825-4297', 'casie.good@aol.com'), 
    ('Reena', 'Maisto', '9648 S Main', 'Salisbury', 'MD', '21801', '410-351-1863', '410-951-2667', 'reena@hotmail.com'), 
    ('Mirta', 'Mallett', '7 S San Marcos Rd', 'New York', 'NY', '10004', '212-870-1286', '212-745-6948', 'mirta_mallett@gmail.com'), 
    ('Cathrine', 'Pontoriero', '812 S Haven St', 'Amarillo', 'TX', '79109', '806-703-1435', '806-558-5848', 'cathrine.pontoriero@pontoriero.com'), 
    ('Filiberto', 'Tawil', '3882 W Congress St Apt 799', 'Los Angeles', 'CA', '90016', '323-765-2528', '323-842-8226', 'ftawil@hotmail.com'), 
    ('Raul', 'Upthegrove', '4 E Colonial Dr', 'La Mesa', 'CA', '91942', '619-509-5282', '619-666-4765', 'rupthegrove@yahoo.com'), 
    ('Sarah', 'Candlish', '45 2nd Ave Apt 9759', 'Atlanta', 'GA', '30328', '770-732-1194', '770-531-2842', 'sarah.candlish@gmail.com'), 
    ('Lucy', 'Treston', '57254 Brickell Ave Apt 372', 'Worcester', 'MA', '1602', '508-769-5250', '508-502-5634', 'lucy@cox.net'), 
    ('Judy', 'Aquas', '8977 Connecticut Ave Nw Apt 3', 'Niles', 'MI', '49120', '269-756-7222', '269-431-9464', 'jaquas@aquas.com'), 
    ('Yvonne', 'Tjepkema', '9 Waydell St', 'Fairfield', 'NJ', '7004', '973-714-1721', '973-976-8627', 'yvonne.tjepkema@hotmail.com'), 
    ('Kayleigh', 'Lace', '43 Huey P Long Ave', 'Lafayette', 'LA', '70508', '337-740-9323', '337-751-2326', 'kayleigh.lace@yahoo.com'), 
    ('Felix', 'Hirpara', '7563 Cornwall Rd Apt 4462', 'Denver', 'PA', '17517', '717-491-5643', '717-583-1497', 'felix_hirpara@cox.net'), 
    ('Tresa', 'Sweely', '22 Bridle Ln', 'Valley Park', 'MO', '63088', '314-359-9566', '314-231-3514', 'tresa_sweely@hotmail.com'), 
    ('Kristeen', 'Turinetti', '70099 E North Ave', 'Arlington', 'TX', '76013', '817-213-8851', '817-947-9480', 'kristeen@gmail.com'), 
    ('Jenelle', 'Regusters', '3211 E Northeast Loop', 'Tampa', 'FL', '33619', '813-932-8715', '813-357-7296', 'jregusters@regusters.com'), 
    ('Renea', 'Monterrubio', '26 Montgomery St', 'Atlanta', 'GA', '30328', '770-679-4752', '770-930-9967', 'renea@hotmail.com'), 
    ('Olive', 'Matuszak', '13252 Lighthouse Ave', 'Cathedral City', 'CA', '92234', '760-938-6069', '760-745-2649', 'olive@aol.com'), 
    ('Ligia', 'Reiber', '206 Main St Apt 2804', 'Lansing', 'MI', '48933', '517-906-1108', '517-747-7664', 'lreiber@cox.net'), 
    ('Christiane', 'Eschberger', '96541 W Central Blvd', 'Phoenix', 'AZ', '85034', '602-390-4944', '602-330-6894', 'christiane.eschberger@yahoo.com'), 
    ('Goldie', 'Schirpke', '34 Saint George Ave Apt 2', 'Bangor', 'ME', '4401', '207-295-7569', '207-748-3722', 'goldie.schirpke@yahoo.com'), 
    ('Loreta', 'Timenez', '47857 Coney Island Ave', 'Clinton', 'MD', '20735', '301-696-6420', '301-392-6698', 'loreta.timenez@hotmail.com'), 
    ('Fabiola', 'Hauenstein', '8573 Lincoln Blvd', 'York', 'PA', '17404', '717-809-3119', '717-344-2804', 'fabiola.hauenstein@hauenstein.org'), 
    ('Amie', 'Perigo', '596 Santa Maria Ave Apt 7913', 'Mesquite', 'TX', '75150', '972-419-7946', '972-898-1033', 'amie.perigo@yahoo.com'), 
    ('Raina', 'Brachle', '3829 Ventura Blvd', 'Butte', 'MT', '59701', '406-318-1515', '406-374-7752', 'raina.brachle@brachle.org'), 
    ('Erinn', 'Canlas', '13 S Hacienda Dr', 'Livingston', 'NJ', '7039', '973-767-3008', '973-563-9502', 'erinn.canlas@canlas.com'), 
    ('Cherry', 'Lietz', '40 9th Ave Sw Apt 91', 'Waterford', 'MI', '48329', '248-980-6904', '248-697-7722', 'cherry@lietz.com'), 
    ('Kattie', 'Vonasek', '2845 Boulder Crescent St', 'Cleveland', 'OH', '44103', '216-923-3715', '216-270-9653', 'kattie@vonasek.org'), 
    ('Lilli', 'Scriven', '33 State St', 'Abilene', 'TX', '79601', '325-631-1560', '325-667-7868', 'lilli@aol.com'), 
    ('Whitley', 'Tomasulo', '2 S 15th St', 'Fort Worth', 'TX', '76107', '817-526-4408', '817-819-7799', 'whitley.tomasulo@aol.com'), 
    ('Barbra', 'Adkin', '4 Kohler Memorial Dr', 'Brooklyn', 'NY', '11230', '718-201-3751', '718-732-9475', 'badkin@hotmail.com'), 
    ('Hermila', 'Thyberg', '1 Rancho Del Mar Shopping C', 'Providence', 'RI', '2903', '401-893-4882', '401-885-7681', 'hermila_thyberg@hotmail.com'), 
    ('Jesusita', 'Flister', '3943 N Highland Ave', 'Lancaster', 'PA', '17601', '717-885-9118', '717-686-7564', 'jesusita.flister@hotmail.com'), 
    ('Caitlin', 'Julia', '5 Williams St', 'Johnston', 'RI', '2919', '401-948-4982', '401-552-9059', 'caitlin.julia@julia.org'), 
    ('Roosevelt', 'Hoffis', '60 Old Dover Rd', 'Hialeah', 'FL', '33014', '305-622-4739', '305-302-1135', 'roosevelt.hoffis@aol.com'), 
    ('Helaine', 'Halter', '8 Sheridan Rd', 'Jersey City', 'NJ', '7304', '201-832-4168', '201-412-3040', 'hhalter@yahoo.com'), 
    ('Lorean', 'Martabano', '85092 Southern Blvd', 'San Antonio', 'TX', '78204', '210-856-4979', '210-634-2447', 'lorean.martabano@hotmail.com'), 
    ('France', 'Buzick', '64 Newman Springs Rd E', 'Brooklyn', 'NY', '11219', '718-478-8504', '718-853-3740', 'france.buzick@yahoo.com'), 
    ('Justine', 'Ferrario', '48 Stratford Ave', 'Pomona', 'CA', '91768', '909-993-3242', '909-631-5703', 'jferrario@hotmail.com'), 
    ('Adelina', 'Nabours', '80 Pittsford Victor Rd Apt 9', 'Cleveland', 'OH', '44103', '216-230-4892', '216-937-5320', 'adelina_nabours@gmail.com'), 
    ('Derick', 'Dhamer', '87163 N Main Ave', 'New York', 'NY', '10013', '212-304-4515', '212-225-9676', 'ddhamer@cox.net'), 
    ('Jerry', 'Dallen', '393 Lafayette Ave', 'Richmond', 'VA', '23219', '804-762-9576', '804-808-9574', 'jerry.dallen@yahoo.com'), 
    ('Leota', 'Ragel', '99 5th Ave Apt 33', 'Trion', 'GA', '30753', '706-221-4243', '706-616-5131', 'leota.ragel@gmail.com'), 
    ('Jutta', 'Amyot', '49 N Mays St', 'Broussard', 'LA', '70518', '337-515-1438', '337-991-8070', 'jamyot@hotmail.com'), 
    ('Aja', 'Gehrett', '993 Washington Ave', 'Nutley', 'NJ', '7110', '973-544-2677', '973-986-4456', 'aja_gehrett@hotmail.com'), 
    ('Kirk', 'Herritt', '88 15th Ave Ne', 'Vestal', 'NY', '13850', '607-407-3716', '607-350-7690', 'kirk.herritt@aol.com'), 
    ('Leonora', 'Mauson', '3381 E 40th Ave', 'Passaic', 'NJ', '7055', '973-412-2995', '973-355-2120', 'leonora@yahoo.com'), 
    ('Winfred', 'Brucato', '201 Ridgewood Rd', 'Moscow', 'ID', '83843', '208-252-4552', '208-793-4108', 'winfred_brucato@hotmail.com'), 
    ('Tarra', 'Nachor', '39 Moccasin Dr', 'San Francisco', 'CA', '94104', '415-411-1775', '415-284-2730', 'tarra.nachor@cox.net'), 
    ('Corinne', 'Loder', '4 Carroll St', 'North Attleboro', 'MA', '2760', '508-942-4186', '508-618-7826', 'corinne@loder.org'), 
    ('Dulce', 'Labreche', '9581 E Arapahoe Rd', 'Rochester', 'MI', '48307', '248-357-8718', '248-811-5696', 'dulce_labreche@yahoo.com'), 
    ('Kate', 'Keneipp', '33 N Michigan Ave', 'Green Bay', 'WI', '54301', '920-353-6377', '920-355-1610', 'kate_keneipp@yahoo.com'), 
    ('Kaitlyn', 'Ogg', '2 S Biscayne Blvd', 'Baltimore', 'MD', '21230', '410-665-4903', '410-773-3862', 'kaitlyn.ogg@gmail.com'), 
    ('Sherita', 'Saras', '8 Us Highway 22', 'Colorado Springs', 'CO', '80937', '719-669-1664', '719-547-9543', 'sherita.saras@cox.net'), 
    ('Lashawnda', 'Stuer', '7422 Martin Ave Apt 8', 'Toledo', 'OH', '43607', '419-588-8719', '419-399-1744', 'lstuer@cox.net'), 
    ('Ernest', 'Syrop', '94 Chase Rd', 'Hyattsville', 'MD', '20785', '301-998-9644', '301-257-4883', 'ernest@cox.net'), 
    ('Nobuko', 'Halsey', '8139 I Hwy 10 Apt 92', 'New Bedford', 'MA', '2745', '508-855-9887', '508-897-7916', 'nobuko.halsey@yahoo.com'), 
    ('Lavonna', 'Wolny', '5 Cabot Rd', 'Mc Lean', 'VA', '22102', '703-483-1970', '703-892-2914', 'lavonna.wolny@hotmail.com'), 
    ('Lashaunda', 'Lizama', '3387 Ryan Dr', 'Hanover', 'MD', '21076', '410-678-2473', '410-912-6032', 'llizama@cox.net'), 
    ('Mariann', 'Bilden', '3125 Packer Ave Apt 9851', 'Austin', 'TX', '78753', '512-223-4791', '512-742-1149', 'mariann.bilden@aol.com'), 
    ('Helene', 'Rodenberger', '347 Chestnut St', 'Peoria', 'AZ', '85381', '623-461-8551', '623-426-4907', 'helene@aol.com'), 
    ('Roselle', 'Estell', '8116 Mount Vernon Ave', 'Bucyrus', 'OH', '44820', '419-571-5920', '419-488-6648', 'roselle.estell@hotmail.com'), 
    ('Samira', 'Heintzman', '8772 Old County Rd Apt 5410', 'Kent', 'WA', '98032', '206-311-4137', '206-923-6042', 'sheintzman@hotmail.com'), 
    ('Margart', 'Meisel', '868 State St Apt 38', 'Cincinnati', 'OH', '45251', '513-617-2362', '513-747-9603', 'margart_meisel@yahoo.com'), 
    ('Kristofer', 'Bennick', '772 W River Dr', 'Bloomington', 'IN', '47404', '812-368-1511', '812-442-8544', 'kristofer.bennick@yahoo.com'), 
    ('Weldon', 'Acuff', '73 W Barstow Ave', 'Arlington Heights', 'IL', '60004', '847-353-2156', '847-613-5866', 'wacuff@gmail.com'), 
    ('Shalon', 'Shadrick', '61047 Mayfield Ave', 'Brooklyn', 'NY', '11223', '718-232-2337', '718-394-4974', 'shalon@cox.net'), 
    ('Denise', 'Patak', '2139 Santa Rosa Ave', 'Orlando', 'FL', '32801', '407-446-4358', '407-808-3254', 'denise@patak.org'), 
    ('Louvenia', 'Beech', '598 43rd St', 'Beverly Hills', 'CA', '90210', '310-820-2117', '310-652-2379', 'louvenia.beech@beech.com'), 
    ('Audry', 'Yaw', '70295 Pioneer Ct', 'Brandon', 'FL', '33511', '813-797-4816', '813-744-7100', 'audry.yaw@yaw.org'), 
    ('Kristel', 'Ehmann', '92899 Kalakaua Ave', 'El Paso', 'TX', '79925', '915-452-1290', '915-300-6100', 'kristel.ehmann@aol.com'), 
    ('Vincenza', 'Zepp', '395 S 6th St Apt 2', 'El Cajon', 'CA', '92020', '619-603-5125', '619-935-6661', 'vzepp@gmail.com'), 
    ('Elouise', 'Gwalthney', '9506 Edgemore Ave', 'Bladensburg', 'MD', '20710', '301-841-5012', '301-591-3034', 'egwalthney@yahoo.com'), 
    ('Venita', 'Maillard', '72119 S Walker Ave Apt 63', 'Anaheim', 'CA', '92801', '714-523-6653', '714-663-9740', 'venita_maillard@gmail.com'), 
    ('Kasandra', 'Semidey', '369 Latham St Apt 500', 'Saint Louis', 'MO', '63102', '314-732-9131', '314-697-3652', 'kasandra_semidey@semidey.com'), 
    ('Xochitl', 'Discipio', '3158 Runamuck Pl', 'Round Rock', 'TX', '78664', '512-233-1831', '512-942-3411', 'xdiscipio@gmail.com'), 
    ('Maile', 'Linahan', '9 Plainsboro Rd Apt 598', 'Greensboro', 'NC', '27409', '336-670-2640', '336-364-6037', 'mlinahan@yahoo.com'), 
    ('Krissy', 'Rauser', '8728 S Broad St', 'Coram', 'NY', '11727', '631-443-4710', '631-288-2866', 'krauser@cox.net'), 
    ('Pete', 'Dubaldi', '2215 Prosperity Dr', 'Lyndhurst', 'NJ', '7071', '201-825-2514', '201-749-8866', 'pdubaldi@hotmail.com'), 
    ('Linn', 'Paa', '1 S Pine St', 'Memphis', 'TN', '38112', '901-412-4381', '901-573-9024', 'linn_paa@paa.com'), 
    ('Paris', 'Wide', '187 Market St', 'Atlanta', 'GA', '30342', '404-505-4445', '404-607-8435', 'paris@hotmail.com'), 
    ('Wynell', 'Dorshorst', '94290 S Buchanan St', 'Pacifica', 'CA', '94044', '650-473-1262', '650-749-9879', 'wynell_dorshorst@dorshorst.org'), 
    ('Quentin', 'Birkner', '7061 N 2nd St', 'Burnsville', 'MN', '55337', '952-702-7993', '952-314-5871', 'qbirkner@aol.com'), 
    ('Regenia', 'Kannady', '10759 Main St', 'Scottsdale', 'AZ', '85260', '480-726-1280', '480-205-5121', 'regenia.kannady@cox.net'), 
    ('Sheron', 'Louissant', '97 E 3rd St Apt 9', 'Long Island City', 'NY', '11101', '718-976-8610', '718-613-9994', 'sheron@aol.com'), 
    ('Izetta', 'Funnell', '82 Winsor St Apt 54', 'Atlanta', 'GA', '30340', '770-844-3447', '770-584-4119', 'izetta.funnell@hotmail.com'), 
    ('Rodolfo', 'Butzen', '41 Steel Ct', 'Northfield', 'MN', '55057', '507-210-3510', '507-590-5237', 'rodolfo@hotmail.com'), 
    ('Zona', 'Colla', '49440 Dearborn St', 'Norwalk', 'CT', '6854', '203-461-1949', '203-938-2557', 'zona@hotmail.com'), 
    ('Serina', 'Zagen', '7 S Beverly Dr', 'Fort Wayne', 'IN', '46802', '260-273-3725', '260-382-4869', 'szagen@aol.com'), 
    ('Paz', 'Sahagun', '919 Wall Blvd', 'Meridian', 'MS', '39307', '601-927-8287', '601-249-4511', 'paz_sahagun@cox.net'), 
    ('Markus', 'Lukasik', '89 20th St E Apt 779', 'Sterling Heights', 'MI', '48310', '586-970-7380', '586-247-1614', 'markus@yahoo.com'), 
    ('Jaclyn', 'Bachman', '721 Interstate 45 S', 'Colorado Springs', 'CO', '80919', '719-853-3600', '719-223-2074', 'jaclyn@aol.com'), 
    ('Cyril', 'Daufeldt', '3 Lawton St', 'New York', 'NY', '10013', '212-745-8484', '212-422-5427', 'cyril_daufeldt@daufeldt.com'), 
    ('Gayla', 'Schnitzler', '38 Pleasant Hill Rd', 'Hayward', 'CA', '94545', '510-686-3407', '510-441-4055', 'gschnitzler@gmail.com'), 
    ('Erick', 'Nievas', '45 E Acacia Ct', 'Chicago', 'IL', '60624', '773-704-9903', '773-359-6109', 'erick_nievas@aol.com'), 
    ('Jennie', 'Drymon', '63728 Poway Rd Apt 1', 'Scranton', 'PA', '18509', '570-218-4831', '570-868-8688', 'jennie@cox.net'), 
    ('Mitsue', 'Scipione', '77 222 Dr', 'Oroville', 'CA', '95965', '530-986-9272', '530-399-3254', 'mscipione@scipione.com'), 
    ('Ciara', 'Ventura', '53 W Carey St', 'Port Jervis', 'NY', '12771', '845-823-8877', '845-694-7919', 'cventura@yahoo.com'), 
    ('Galen', 'Cantres', '617 Nw 36th Ave', 'Brook Park', 'OH', '44142', '216-600-6111', '216-871-6876', 'galen@yahoo.com'), 
    ('Truman', 'Feichtner', '539 Coldwater Canyon Ave', 'Bloomfield', 'NJ', '7003', '973-852-2736', '973-473-5108', 'tfeichtner@yahoo.com'), 
    ('Gail', 'Kitty', '735 Crawford Dr', 'Anchorage', 'AK', '99501', '907-435-9166', '907-770-3542', 'gail@kitty.com'), 
    ('Dalene', 'Schoeneck', '910 Rahway Ave', 'Philadelphia', 'PA', '19102', '215-268-1275', '215-380-8820', 'dalene@schoeneck.org'), 
    ('Gertude', 'Witten', '7 Tarrytown Rd', 'Cincinnati', 'OH', '45217', '513-977-7043', '513-863-9471', 'gertude.witten@gmail.com'), 
    ('Lizbeth', 'Kohl', '35433 Blake St Apt 588', 'Gardena', 'CA', '90248', '310-699-1222', '310-955-5788', 'lizbeth@yahoo.com'), 
    ('Glenn', 'Berray', '29 Cherry St Apt 7073', 'Des Moines', 'IA', '50315', '515-370-7348', '515-372-1738', 'gberray@gmail.com'), 
    ('Lashandra', 'Klang', '810 N La Brea Ave', 'King of Prussia', 'PA', '19406', '610-809-1818', '610-378-7332', 'lashandra@yahoo.com'), 
    ('Lenna', 'Newville', '987 Main St', 'Raleigh', 'NC', '27601', '919-623-2524', '919-254-5987', 'lnewville@newville.com'), 
    ('Laurel', 'Pagliuca', '36 Enterprise St Se', 'Richland', 'WA', '99352', '509-695-5199', '509-595-6485', 'laurel@yahoo.com'), 
    ('Mireya', 'Frerking', '8429 Miller Rd', 'Pelham', 'NY', '10803', '914-868-5965', '914-883-3061', 'mireya.frerking@hotmail.com'), 
    ('Annelle', 'Tagala', '5 W 7th St', 'Parkville', 'MD', '21234', '410-757-1035', '410-234-2267', 'annelle@yahoo.com'), 
    ('Dean', 'Ketelsen', '2 Flynn Rd', 'Hicksville', 'NY', '11801', '516-847-4418', '516-732-6649', 'dean_ketelsen@gmail.com'), 
    ('Levi', 'Munis', '2094 Ne 36th Ave', 'Worcester', 'MA', '1603', '508-456-4907', '508-658-7802', 'levi.munis@gmail.com'), 
    ('Sylvie', 'Ryser', '649 Tulane Ave', 'Tulsa', 'OK', '74105', '918-644-9555', '918-565-1706', 'sylvie@aol.com'), 
    ('Sharee', 'Maile', '2094 Montour Blvd', 'Muskegon', 'MI', '49442', '231-467-9978', '231-265-6940', 'sharee_maile@aol.com'), 
    ('Cordelia', 'Storment', '393 Hammond Dr', 'Lafayette', 'LA', '70506', '337-566-6001', '337-255-3427', 'cordelia_storment@aol.com'), 
    ('Mollie', 'Mcdoniel', '8590 Lake Lizzie Dr', 'Bowling Green', 'OH', '43402', '419-975-3182', '419-417-4674', 'mollie_mcdoniel@yahoo.com'), 
    ('Brett', 'Mccullan', '87895 Concord Rd', 'La Mesa', 'CA', '91942', '619-461-9984', '619-727-3892', 'brett.mccullan@mccullan.com'), 
    ('Teddy', 'Pedrozo', '46314 Route 130', 'Bridgeport', 'CT', '6610', '203-892-3863', '203-918-3939', 'teddy_pedrozo@aol.com'), 
    ('Tasia', 'Andreason', '4 Cowesett Ave', 'Kearny', 'NJ', '7032', '201-920-9002', '201-969-7063', 'tasia_andreason@yahoo.com'), 
    ('Hubert', 'Walthall', '95 Main Ave Apt 2', 'Barberton', 'OH', '44203', '330-903-1345', '330-566-8898', 'hubert@walthall.org'), 
    ('Arthur', 'Farrow', '28 S 7th St Apt 2824', 'Englewood', 'NJ', '7631', '201-238-5688', '201-772-4377', 'arthur.farrow@yahoo.com'), 
    ('Vilma', 'Berlanga', '79 S Howell Ave', 'Grand Rapids', 'MI', '49546', '616-737-3085', '616-568-4113', 'vberlanga@berlanga.com'), 
    ('Billye', 'Miro', '36 Lancaster Dr Se', 'Pearl', 'MS', '39208', '601-567-5386', '601-637-5479', 'billye_miro@cox.net'), 
    ('Glenna', 'Slayton', '2759 Livingston Ave', 'Memphis', 'TN', '38118', '901-640-9178', '901-869-4314', 'glenna_slayton@cox.net'), 
    ('Mitzie', 'Hudnall', '17 Jersey Ave', 'Englewood', 'CO', '80110', '303-402-1940', '303-997-7760', 'mitzie_hudnall@yahoo.com'), 
    ('Bernardine', 'Rodefer', '2 W Grand Ave', 'Memphis', 'TN', '38112', '901-901-4726', '901-739-5892', 'bernardine_rodefer@yahoo.com'), 
    ('Staci', 'Schmaltz', '18 Coronado Ave Apt 563', 'Pasadena', 'CA', '91106', '626-866-2339', '626-293-7678', 'staci_schmaltz@aol.com'), 
    ('Nichelle', 'Meteer', '72 Beechwood Ter', 'Chicago', 'IL', '60657', '773-225-9985', '773-857-2231', 'nichelle_meteer@meteer.com'), 
    ('Janine', 'Rhoden', '92 Broadway', 'Astoria', 'NY', '11103', '718-228-5894', '718-728-5051', 'jrhoden@yahoo.com'), 
    ('Ettie', 'Hoopengardner', '39 Franklin Ave', 'Richland', 'WA', '99352', '509-755-5393', '509-847-3352', 'ettie.hoopengardner@hotmail.com'), 
    ('Eden', 'Jayson', '4 Iwaena St', 'Baltimore', 'MD', '21202', '410-890-7866', '410-429-4888', 'eden_jayson@yahoo.com'), 
    ('Lynelle', 'Auber', '32820 Corkwood Rd', 'Newark', 'NJ', '7104', '973-860-8610', '973-605-6492', 'lynelle_auber@gmail.com'), 
    ('Merissa', 'Tomblin', '34 Raritan Center Pky', 'Bellflower', 'CA', '90706', '562-579-6900', '562-719-7922', 'merissa.tomblin@gmail.com'), 
    ('Golda', 'Kaniecki', '6201 S Nevada Ave', 'Toms River', 'NJ', '8755', '732-628-9909', '732-617-5310', 'golda_kaniecki@yahoo.com'), 
    ('Catarina', 'Gleich', '78 Maryland Dr Apt 146', 'Denville', 'NJ', '7834', '973-210-3994', '973-491-8723', 'catarina_gleich@hotmail.com'), 
    ('Virgie', 'Kiel', '76598 Rd  I 95 Apt 1', 'Denver', 'CO', '80216', '303-776-7548', '303-845-5408', 'vkiel@hotmail.com'), 
    ('Jolene', 'Ostolaza', '1610 14th St Nw', 'Newport News', 'VA', '23608', '757-682-7116', '757-940-1741', 'jolene@yahoo.com'), 
    ('Keneth', 'Borgman', '86350 Roszel Rd', 'Phoenix', 'AZ', '85012', '602-919-4211', '602-442-3092', 'keneth@yahoo.com'), 
    ('Rikki', 'Nayar', '1644 Clove Rd', 'Miami', 'FL', '33155', '305-968-9487', '305-978-2069', 'rikki@nayar.com'), 
    ('Elke', 'Sengbusch', '9 W Central Ave', 'Phoenix', 'AZ', '85013', '602-896-2993', '602-575-3457', 'elke_sengbusch@yahoo.com'), 
    ('Hoa', 'Sarao', '27846 Lafayette Ave', 'Oak Hill', 'FL', '32759', '386-526-7800', '386-599-7296', 'hoa@sarao.org'), 
    ('Trinidad', 'Mcrae', '10276 Brooks St', 'San Francisco', 'CA', '94105', '415-331-9634', '415-419-1597', 'trinidad_mcrae@yahoo.com'), 
    ('Mari', 'Lueckenbach', '1 Century Park E', 'San Diego', 'CA', '92110', '858-793-9684', '858-228-5683', 'mari_lueckenbach@yahoo.com'), 
    ('Selma', 'Husser', '9 State Highway 57 Apt 22', 'Jersey City', 'NJ', '7306', '201-991-8369', '201-772-7699', 'selma.husser@cox.net'), 
    ('Antione', 'Onofrio', '4 S Washington Ave', 'San Bernardino', 'CA', '92410', '909-430-7765', '909-665-3223', 'aonofrio@onofrio.com'), 
    ('Luisa', 'Jurney', '25 Se 176th Pl', 'Cambridge', 'MA', '2138', '617-365-2134', '617-544-2541', 'ljurney@hotmail.com'), 
    ('Clorinda', 'Heimann', '105 Richmond Valley Rd', 'Escondido', 'CA', '92025', '760-291-5497', '760-261-4786', 'clorinda.heimann@hotmail.com'), 
    ('Dick', 'Wenzinger', '22 Spruce St Apt 595', 'Gardena', 'CA', '90248', '310-510-9713', '310-936-2258', 'dick@yahoo.com'), 
    ('Ahmed', 'Angalich', '2 W Beverly Blvd', 'Harrisburg', 'PA', '17110', '717-528-8996', '717-632-5831', 'ahmed.angalich@angalich.com'), 
    ('Iluminada', 'Ohms', '72 Southern Blvd', 'Mesa', 'AZ', '85204', '480-293-2882', '480-866-6544', 'iluminada.ohms@yahoo.com'), 
    ('Joanna', 'Leinenbach', '1 Washington St', 'Lake Worth', 'FL', '33461', '561-470-4574', '561-951-9734', 'joanna_leinenbach@hotmail.com'), 
    ('Caprice', 'Suell', '90177 N 55th Ave', 'Nashville', 'TN', '37211', '615-246-1824', '615-726-4537', 'caprice@aol.com'), 
    ('Stephane', 'Myricks', '9 Tower Ave', 'Burlington', 'KY', '41005', '859-717-7638', '859-308-4286', 'stephane_myricks@cox.net'), 
    ('Quentin', 'Swayze', '278 Bayview Ave', 'Milan', 'MI', '48160', '734-561-6170', '734-851-8571', 'quentin_swayze@yahoo.com'), 
    ('Annmarie', 'Castros', '80312 W 32nd St', 'Conroe', 'TX', '77301', '936-751-7961', '936-937-2334', 'annmarie_castros@gmail.com'), 
    ('Shonda', 'Greenbush', '82 Us Highway 46', 'Clifton', 'NJ', '7011', '973-482-2430', '973-644-2974', 'shonda_greenbush@cox.net'), 
    ('Cecil', 'Lapage', '4 Stovall St Apt 72', 'Union City', 'NJ', '7087', '201-693-3967', '201-856-2720', 'clapage@lapage.com'), 
    ('Jeanice', 'Claucherty', '19 Amboy Ave', 'Miami', 'FL', '33142', '305-988-4162', '305-306-7834', 'jeanice.claucherty@yahoo.com'), 
    ('Josphine', 'Villanueva', '63 Smith Ln Apt 8343', 'Moss', 'TN', '38575', '931-553-9774', '931-486-6946', 'josphine_villanueva@villanueva.com'), 
    ('Daniel', 'Perruzza', '11360 S Halsted St', 'Santa Ana', 'CA', '92705', '714-771-3880', '714-531-1391', 'dperruzza@perruzza.com'), 
    ('Cassi', 'Wildfong', '26849 Jefferson Hwy', 'Rolling Meadows', 'IL', '60008', '847-633-3216', '847-755-9041', 'cassi.wildfong@aol.com'), 
    ('Britt', 'Galam', '2500 Pringle Rd Se Apt 508', 'Hatfield', 'PA', '19440', '215-888-3304', '215-351-8523', 'britt@galam.org'), 
    ('Adell', 'Lipkin', '65 Mountain View Dr', 'Whippany', 'NJ', '7981', '973-654-1561', '973-662-8988', 'adell.lipkin@lipkin.com'), 
    ('Jacqueline', 'Rowling', '1 N San Saba', 'Erie', 'PA', '16501', '814-865-8113', '814-481-1700', 'jacqueline.rowling@yahoo.com'), 
    ('Lonny', 'Weglarz', '51120 State Route 18', 'Salt Lake City', 'UT', '84115', '801-293-9853', '801-892-8781', 'lonny_weglarz@gmail.com'), 
    ('Lonna', 'Diestel', '1482 College Ave', 'Fayetteville', 'NC', '28301', '910-922-3672', '910-200-7912', 'lonna_diestel@gmail.com'), 
    ('Cristal', 'Samara', '4119 Metropolitan Dr', 'Los Angeles', 'CA', '90021', '213-975-8026', '213-696-8004', 'cristal@cox.net'), 
    ('Kenneth', 'Grenet', '2167 Sierra Rd', 'East Lansing', 'MI', '48823', '517-499-2322', '517-867-8077', 'kenneth.grenet@grenet.org'), 
    ('Elli', 'Mclaird', '6 Sunrise Ave', 'Utica', 'NY', '13501', '315-818-2638', '315-474-5570', 'emclaird@mclaird.com'), 
    ('Alline', 'Jeanty', '55713 Lake City Hwy', 'South Bend', 'IN', '46601', '574-656-2800', '574-405-1983', 'ajeanty@gmail.com'), 
    ('Sharika', 'Eanes', '75698 N Fiesta Blvd', 'Orlando', 'FL', '32806', '407-312-1691', '407-472-1332', 'sharika.eanes@aol.com'), 
    ('Nu', 'Mcnease', '88 Sw 28th Ter', 'Harrison', 'NJ', '7029', '973-751-9003', '973-903-4175', 'nu@gmail.com'), 
    ('Daniela', 'Comnick', '7 Flowers Rd Apt 403', 'Trenton', 'NJ', '8611', '609-200-8577', '609-398-2805', 'dcomnick@cox.net'), 
    ('Cecilia', 'Colaizzo', '4 Nw 12th St Apt 3849', 'Madison', 'WI', '53717', '608-382-4541', '608-302-3387', 'cecilia_colaizzo@colaizzo.com'), 
    ('Leslie', 'Threets', '2 A Kelley Dr', 'Katonah', 'NY', '10536', '914-861-9748', '914-396-2615', 'leslie@cox.net'), 
    ('Nan', 'Koppinger', '88827 Frankford Ave', 'Greensboro', 'NC', '27401', '336-370-5333', '336-564-1492', 'nan@koppinger.com'), 
    ('Izetta', 'Dewar', '2 W Scyene Rd Apt 3', 'Baltimore', 'MD', '21217', '410-473-1708', '410-522-7621', 'idewar@dewar.com'), 
    ('Tegan', 'Arceo', '62260 Park Stre', 'Monroe Township', 'NJ', '8831', '732-730-2692', '732-705-6719', 'tegan.arceo@arceo.org'), 
    ('Ruthann', 'Keener', '3424 29th St Se', 'Kerrville', 'TX', '78028', '830-258-2769', '830-919-5991', 'ruthann@hotmail.com'), 
    ('Joni', 'Breland', '35 E Main St Apt 43', 'Elk Grove Village', 'IL', '60007', '847-519-5906', '847-740-5304', 'joni_breland@cox.net'), 
    ('Vi', 'Rentfro', '7163 W Clark Rd', 'Freehold', 'NJ', '7728', '732-605-4781', '732-724-7251', 'vrentfro@cox.net'), 
    ('Colette', 'Kardas', '21575 S Apple Creek Rd', 'Omaha', 'NE', '68124', '402-896-5943', '402-707-1602', 'colette.kardas@yahoo.com'), 
    ('Malcolm', 'Tromblay', '747 Leonis Blvd', 'Annandale', 'VA', '22003', '703-221-5602', '703-874-4248', 'malcolm_tromblay@cox.net'), 
    ('Ryan', 'Harnos', '13 Gunnison St', 'Plano', 'TX', '75075', '972-558-1665', '972-961-4968', 'ryan@cox.net'), 
    ('Jess', 'Chaffins', '18 3rd Ave', 'New York', 'NY', '10016', '212-510-4633', '212-428-9538', 'jess.chaffins@chaffins.org'), 
    ('Sharen', 'Bourbon', '62 W Austin St', 'Syosset', 'NY', '11791', '516-816-1541', '516-749-3188', 'sbourbon@yahoo.com'), 
    ('Nickolas', 'Juvera', '177 S Rider Trl Apt 52', 'Crystal River', 'FL', '34429', '352-598-8301', '352-947-6152', 'nickolas_juvera@cox.net'), 
    ('Gary', 'Nunlee', '2 W Mount Royal Ave', 'Fortville', 'IN', '46040', '317-542-6023', '317-887-8486', 'gary_nunlee@nunlee.org'), 
    ('Diane', 'Devreese', '1953 Telegraph Rd', 'Saint Joseph', 'MO', '64504', '816-557-9673', '816-329-5565', 'diane@cox.net'), 
    ('Roslyn', 'Chavous', '63517 Dupont St', 'Jackson', 'MS', '39211', '601-234-9632', '601-973-5754', 'roslyn.chavous@chavous.org'), 
    ('Glory', 'Schieler', '5 E Truman Rd', 'Abilene', 'TX', '79602', '325-869-2649', '325-740-3778', 'glory@yahoo.com'), 
    ('Rasheeda', 'Sayaphon', '251 Park Ave Apt 979', 'Saratoga', 'CA', '95070', '408-805-4309', '408-997-7490', 'rasheeda@aol.com'), 
    ('Alpha', 'Palaia', '43496 Commercial Dr Apt 29', 'Cherry Hill', 'NJ', '8003', '856-312-2629', '856-513-7024', 'alpha@yahoo.com'), 
    ('Refugia', 'Jacobos', '2184 Worth St', 'Hayward', 'CA', '94545', '510-974-8671', '510-509-3496', 'refugia.jacobos@jacobos.com'), 
    ('Shawnda', 'Yori', '50126 N Plankinton Ave', 'Longwood', 'FL', '32750', '407-538-5106', '407-564-8113', 'shawnda.yori@yahoo.com'), 
    ('Mona', 'Delasancha', '38773 Gravois Ave', 'Cheyenne', 'WY', '82001', '307-403-1488', '307-816-7115', 'mdelasancha@hotmail.com'), 
    ('Gilma', 'Liukko', '16452 Greenwich St', 'Garden City', 'NY', '11530', '516-393-9967', '516-407-9573', 'gilma_liukko@gmail.com'), 
    ('Janey', 'Gabisi', '40 Cambridge Ave', 'Madison', 'WI', '53715', '608-967-7194', '608-586-6912', 'jgabisi@hotmail.com'), 
    ('Lili', 'Paskin', '20113 4th Ave E', 'Kearny', 'NJ', '7032', '201-431-2989', '201-478-8540', 'lili.paskin@cox.net'), 
    ('Loren', 'Asar', '6 Ridgewood Center Dr', 'Old Forge', 'PA', '18518', '570-648-3035', '570-569-2356', 'loren.asar@aol.com'), 
    ('Dorothy', 'Chesterfield', '469 Outwater Ln', 'San Diego', 'CA', '92126', '858-617-7834', '858-732-1884', 'dorothy@cox.net'), 
    ('Gail', 'Similton', '62 Monroe St', 'Thousand Palms', 'CA', '92276', '760-616-5388', '760-493-9208', 'gail_similton@similton.com'), 
    ('Catalina', 'Tillotson', '3338 A Lockport Pl Apt 6', 'Margate City', 'NJ', '8402', '609-373-3332', '609-826-4990', 'catalina@hotmail.com'), 
    ('Lawrence', 'Lorens', '9 Hwy', 'Providence', 'RI', '2906', '401-465-6432', '401-893-1820', 'lawrence.lorens@hotmail.com');
    
LOCK TABLES `role` WRITE;

INSERT INTO `role` (`role_id`, `name`)
VALUES
	(1000, 'Stylist'),
    (2000, 'Senior Stylist'),
    (3000, 'Master Stylist');   
    

LOCK TABLES `staff` WRITE;

INSERT INTO `staff` (`staff_id`, `first`, `last`, `address`, `city`, `state`, `zip`, `phone`, `alt_phone`, `email`, `role_id`)
VALUES
	 ('1805', 'Reimer', 'Rebecca', '8284 Hart St', 'Abilene', 'KS', '67410', '785-347-1805', '785-253-7049', 'rebeccar@hotmail.com', 1000), 
    ('3571', 'Moore', 'Mel', '5 Washington St Apt 1', 'Roseville', 'CA', '95678', '916-920-3571', '916-459-2433', 'melm@ankeny.org', 1000), 
    ('4118', 'Snyder', 'Lynn', '8 S Haven St', 'Daytona Beach', 'FL', '32114', '386-248-4118', '386-208-6976', 'lynns@gmail.com', 1000), 
    ('7516', 'Franckowiak', 'Kim Marie', '9 Front St', 'Washington', 'DC', '20001', '202-646-7516', '202-276-6826', 'kim_marief @hixenbaugh.org', 1000), 
    ('3294', 'Klug', 'Jenny', '1933 Packer Ave Apt 2', 'Novato', 'CA', '94945', '415-423-3294', '415-926-6089', 'jennyk@gmail.com', 1000), 
    ('1235', 'Ludtke', 'Patrick', '67 Rv Cent', 'Boise', 'ID', '83709', '208-709-1235', '208-206-9848', 'patrickl@gillaspie.com', 1000), 
    ('1454', 'Johnson', 'Colleen', '2 Sw Nyberg Rd', 'Elkhart', 'IN', '46514', '574-499-1454', '574-330-1884', 'colleenj@kampa.org', 1000), 
    ('2182', 'Kreidler', 'Janelle', '89992 E 15th St', 'Alliance', 'NE', '69301', '308-726-2182', '308-250-6987', 'janellek @cox.net', 1000), 
    ('6498', 'Dean', 'Chaz', '61556 W 20th Ave', 'Seattle', 'WA', '98104', '206-711-6498', '206-395-6284', 'chazd@yahoo.com', 3000), 
    ('4842', 'Stafford', 'Lee', '63 E Aurora Dr', 'Orlando', 'FL', '32804', '407-413-4842', '407-557-8857', 'lees@aol.com', 2000);

LOCK TABLES `status` WRITE;

INSERT INTO `status` (`status_code`, `name`)
VALUES
	(100, 'Available'),
    (200, 'Unavailable'),
    (300, 'Ordered'),
    (400, 'In-Stock'),
    (500, 'Out-of-Stock'),
    (600, 'Shipped'),
    (700, 'Scheduled'),
    (800, 'Confirmed'),
    (900, 'Active'),
    (1000, 'Completed'); 
    
LOCK TABLES `add_on_service` WRITE;
    
INSERT INTO `add_on_service` (`add_on_id`, `name`, `timeblock`)
VALUES
	(1000, 'Deep Condition', 45),
    (2000, 'Clarifying Treatment', 45);
    
INSERT INTO `service` (`service_id`, `name`, `category`, `service_code`, `timeblock`, `role_id`, `price`)
VALUES
	(),
    (),
    ();
    
INSERT INTO `product` (`product_id`, `name`, `upc_code`, `category`, `size`, `vendor_id`, `status_code`, `wholesale_cost`, `retail_price`, `brand`)
VALUES
	(),
    (),
    ();
    
INSERT INTO `vendor` (`vendor_id`, `name`, `order_details`, `notes`)
VALUES
	(),
    (),
    ();
    
INSERT INTO `resource` (`resource_id`, `name`, `description`, `notes`, `type`, `availability_id`)
VALUES
	(),
    (),
    ();  

INSERT INTO `appointment` (`appointment_id`, `service_id`, `customer_id`, `staff_id`, `status_code`, `date`, `start_time`, `end_time`)
VALUES
	(),
    (),
    ();

LOCK TABLES `example_phpmvc` WRITE;

INSERT INTO `example_phpmvc` (`group_id`, `group_parent`, `group_name`)
VALUES
	(1,0,'Bookmarks Menu'),
	(2,0,'Web Dev'),
	(3,0,'School'),
	(4,0,'Work'),
	(8,0,'Music'),
	(9,0,'News'),
	(10,2,'CSS'),
	(11,2,'PHP'),
	(12,2,'HTML'),
	(13,2,'jQuery'),
	(14,2,'Graphics'),
	(15,8,'Production Tools'),
	(16,8,'Samples'),
	(17,8,'Forums'),
	(18,8,'Labels'),
	(19,2,'Tools'),
	(20,2,'Tips'),
	(21,2,'User Interface'),
	(22,2,'Resources'),
	(23,0,'Shopping'),
	(24,0,'Travel'),
	(25,2,'SEO'),
	(26,24,'Properties'),
	(27,2,'Databases'),
	(28,2,'MySQL');

UNLOCK TABLES;

