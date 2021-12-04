create table dealer(
  dealer_id integer,
  first_name varchar(256),
  second_name varchar(256),
  location text,
  primary key (dealer_id)
);
create table sale(
  VIN integer,
  customer_id integer,
  dealer_id integer,
  date date,
  price numeric,
  foreign key(customer_id) references customer
);
alter table customer drop dealer_id;
create table customer(
  customer_id integer,
  first_name varchar(255),
  second_name varchar(255),
  address text,
  phone_number varchar(12),
  gender varchar(6),
  salary numeric,
  dealer_id integer,
  primary key (customer_id),
  foreign key (dealer_id) references dealer
);
create table inventory(
  inventory_id integer,
  name varchar(255),
  location text,
  dealer_id integer,
  primary key (inventory_id,dealer_id),
  foreign key (dealer_id) references dealer
);
create table part(
  part_id integer,
  part_type varchar(255),
  date_of_creation date,
  date_of_supplying date,
  primary key (part_id)
);
create table suppliers(
  supplier_id integer,
  name varchar(255),
  location text,
  primary key (supplier_id)
);
create table manufacturer
(
    m_name      varchar(255),
    location    text,
    supplier_id integer,
    part_id     integer,
    primary key (m_name),
    foreign key (supplier_id) references suppliers,
    foreign key (part_id) references part
);
create table produces(
    m_name varchar(255),
    VIN integer,
    date timestamp,
    primary key (m_name,VIN,date),
    foreign key (m_name) references manufacturer,
    foreign key (VIN) references vehicle
);
create table vehicle(
    VIN integer,
    option_id integer,
    m_name varchar(255),
    inventory_id integer,
    customer_id integer,
    primary key (VIN),
    foreign key (option_id) references option,
    foreign key (customer_id) references customer,
    foreign key (m_name) references manufacturer
);
create table option(
    option_id integer,
    engine varchar(255),
    transmission varchar(255),
    model_name varchar(255),
    color varchar(255),
    primary key (option_id),
    foreign key (model_name) references car_model
);
create table car_model(
    model_name varchar(255),
    year_of_creation integer,
    type_of_car varchar(255),
    brand_name varchar(255),
    primary key (model_name),
    foreign key (brand_name) references brand
);
create table brand(
    brand_name varchar(255),
    number_of_employees integer,
    company_id integer,
    m_name varchar(255),
    primary key (brand_name),
    foreign key (company_id) references company,
    foreign key (m_name) references manufacturer
);

create table company(
    company_id integer,
    company_name varchar(255),
    number_of_employees integer,
    primary key (company_id)
);
create table produce (
  VIN integer,
  m_name varchar(255),
  date date,
  foreign key (VIN) references vehicle,
  foreign key (m_name) references manufacturer
);
insert into dealer values(1,'John','Elton','Washinghton');
insert into dealer values(2,'Johnny','Armstrong','New-York');
insert into dealer values(3,'Olzhas','Dairov','Almaty');
insert into inventory values(1,'ABC123','New-York',2);
insert into inventory values(2,'ABC124','Almaty',3);
insert into inventory values(3,'ABC125','Almaty',1);
insert into part values(1,'A1','2015-12-03','2015-12-04');
insert into part values(2,'A2','2015-12-03','2015-12-04');
insert into part values(3,'A3','2015-12-03','2015-12-04');
insert into suppliers values(1,'A1','Almaty');
insert into suppliers values(2,'A2','Almaty');
insert into suppliers values(3,'A3','Almaty');
insert into manufacturer values('Genzag','Almaty',1,1);
insert into manufacturer values('Motor','Almaty',2,2);
insert into manufacturer values('Kotor','Almaty',3,3);
insert into company values(1,'toyota',10000);
insert into company values(2,'lada',10000);
insert into brand values('lexus',5000,1,'Genzag');
insert into brand values('volga',10000,2,'Motor');
insert into brand values('toyoto',5000,1,'Kotor');
insert into car_model values('lexus1',2000,'B','lexus');
insert into car_model values('lexus2',2001,'A','lexus');
insert into car_model values('lexus3',2002,'C','lexus');
insert into car_model values('toyoto1',2000,'B','lexus');
insert into car_model values('toyoto2',2001,'A','lexus');
insert into car_model values('toyoto3',2002,'C','toyoto');
insert into car_model values('volga1',2000,'B','volga');
insert into car_model values('volga2',2001,'A','volga');
insert into car_model values('volga3',2002,'C','volga');
insert into option values(1,'a','b','lexus1','blue');
insert into option values(2,'a','b','lexus2','blue');
insert into option values(3,'a','b','lexus3','blue');
insert into option values(4,'a','b','toyoto1','blue');
insert into option values(5,'a','b','toyoto2','blue');
insert into option values(6,'a','b','toyoto3','blue');
insert into option values(7,'a','b','volga1','blue');
insert into option values(8,'a','b','volga2','blue');
insert into option values(9,'a','b','volga3','blue');
insert into customer values(1,'Alikh','Kaliyev','Almaty','+77772902908','male',10000);
insert into customer values(2,'Maga','Kaliyev','Almaty','+77772902908','male',10000);
insert into customer values(3,'Aigul','Kaliyeva','Almaty','+77772902908','female',10000);
insert into customer values(4,'Alikh','Beken','Almaty','+77772902908','male',10000);
insert into customer values(5,'Nazir','Kaliyeva','Almaty','+77772902908','female',10000);
insert into customer values(6,'Magzhan','Kaliyeva','Almaty','+77772902908','female',10000);
insert into customer values(7,'Alikhan','Kaliyev','Almaty','+77772902908','male',10000);
insert into customer values(8,'Amina','Kaliyeva','Almaty','+77772902908','female',10000);
insert into customer values(9,'Denis','Kaliyev','Almaty','+77772902908','male',10000);
insert into vehicle values(1,1,'Genzag',1,1);
insert into vehicle values(2,2,'Genzag',1,2);
insert into vehicle values(3,3,'Genzag',1,3);
insert into vehicle values(4,4,'Motor',2,4);
insert into vehicle values(5,5,'Motor',2,5);
insert into vehicle values(6,6,'Motor',2,6);
insert into vehicle values(7,7,'Kotor',3,7);
insert into vehicle values(8,8,'Kotor',3,8);
insert into vehicle values(9,9,'Kotor',3,9);
insert into sale values(1,1,2,'2016-12-03' ,10000);
insert into sale values(2,2,2,'2018-12-03' ,20000);
insert into sale values(3,3,2,'2019-12-03' ,30000);
insert into sale values(4,4,3,'2017-12-03' ,10000);
insert into sale values(5,5,3,'2018-12-03' ,10000);
insert into sale values(6,6,3,'2019-12-03' ,10000);
insert into sale values(7,7,2,'2020-12-03' ,20000);
insert into sale values(8,8,2,'2019-11-23' ,20000);
insert into sale values(9,9,2,'2020-12-03' ,10000);
insert into produce values(1,'Genzag','2016-12-04');
insert into produce values(2,'Genzag','2016-12-04');
insert into produce values(3,'Genzag','2016-12-04');
insert into produce values(4,'Motor','2016-12-04');
insert into produce values(5,'Motor','2016-12-04');
insert into produce values(6,'Motor','2016-12-04');
insert into produce values(7,'Kotor','2016-12-04');
insert into produce values(8,'Kotor','2016-12-04');
insert into produce values(9,'Kotor','2016-12-04');
--1 query
select brand_name,price,date from brand inner join vehicle on brand.m_name=vehicle.m_name inner join sale on vehicle.VIN = sale.VIN
where extract(year from sale.date ) >2017 ;
select brand_name,sum(price) from brand inner join vehicle on brand.m_name=vehicle.m_name inner join sale on vehicle.VIN = sale.VIN
where extract(year from sale.date ) >2017 group by brand_name;
select brand_name,price,gender from brand inner join vehicle on brand.m_name=vehicle.m_name inner join sale on vehicle.VIN = sale.VIN
inner join customer on sale.customer_id = customer.customer_id
where extract(year from sale.date ) >2017 order by gender asc;
--2 query
select distinct  sale.VIN , first_name, second_name,produce.date from customer inner join sale on sale.customer_id= customer.customer_id inner join vehicle on sale.customer_id = vehicle.customer_id inner join produce on vehicle.m_name=produce.m_name
where (produce.m_name = 'Genzag' and (extract(year from produce.date ) >= 2015) and extract(year from produce.date )<=2019);
--3 query
select brand_name,sum(price) as summary from brand inner join vehicle on brand.m_name=vehicle.m_name inner join sale on vehicle.VIN = sale.VIN
where extract(year from sale.date ) =2020 group by brand_name
order by summary desc  limit 2;
--4 query
select brand_name,count(brand_name) as summary from brand inner join vehicle on brand.m_name=vehicle.m_name inner join sale on vehicle.VIN = sale.VIN
where extract(year from sale.date ) =2020 group by brand_name
order by summary desc  limit 2;
--5 query
select distinct extract(month from sale.date) as number_of_month , count(extract(month from sale.date)) as datetime from sale inner join customer on sale.customer_id = customer.customer_id inner join vehicle on customer.customer_id = vehicle.customer_id inner join option on vehicle.option_id = option.option_id inner join car_model on car_model.model_name = option.model_name
where type_of_car='C' group by number_of_month order by  datetime desc limit 1;
-- distinct extract(month from sale.date) as number_of_month , count(extract(month from sale.date))
-- type_of_car='C' group by number_of_month
select number_of_month, datetime from (select extract(month from sale.date) as number_of_month , count(extract(month from sale.date)) as datetime from sale inner join customer on sale.customer_id = customer.customer_id inner join vehicle on customer.customer_id = vehicle.customer_id inner join option on vehicle.option_id = option.option_id inner join car_model on car_model.model_name = option.model_name
where type_of_car='C' group by number_of_month) as lol
where datetime = (select extract(month from sale.date) from sale inner join customer on sale.customer_id = customer.customer_id inner join vehicle on customer.customer_id = vehicle.customer_id inner join option on vehicle.option_id = option.option_id inner join car_model on car_model.model_name = option.model_name
where type_of_car='C');
