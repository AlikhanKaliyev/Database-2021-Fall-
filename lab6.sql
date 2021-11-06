
--1a
select * from dealer cross join client;
--1b
select  d.name as dealer_name, c.name as client_name, c.city as city ,c.priority as priority,s.id as sell_id,s.date as date,s.amount as amount
from dealer as d inner join client as c on d.id=c.dealer_id
inner join sell as s on c.id=s.client_id
order by d.id;
--1c
select d.name as dealer_name,c.name as client_name,d.location
from dealer as d inner join client as c on d.location = c.city;
--1d
select s.id as sell_id,s.amount as amount,c.name as client_name,c.city as city
from sell as s inner join client as c on amount >= 100 and amount <=500 and s.client_id=c.id
order by amount;
--1e
select d.id as dealer_id,d.name as name
from client as c right join dealer as d on d.id = c.dealer_id;
--1f
select c.name as client_name,c.city as city,d.name as dealer_name,d.charge as commision
from client as c inner join dealer as d on d.id = c.dealer_id;
--1g
select c.name as client_name ,c.city as city,d.name as dealer_name,d.charge as commision
from client as c inner join dealer as d on d.charge >0.12 and d.id = c.dealer_id;
--1h
select c.name as client_name,c.city as city,s.id as sell_id,s.date as sell_date,s.amount as sell_amount,d.name as dealer_name,d.charge as commision
from client as c left join dealer as d on d.id = c.dealer_id
left join sell as s on c.id = s.client_id;
--1i
select c.name as client_name,c.priority as grade,d.name as dealer_name,s.id as sell_id, s.amount as sell_amount
from client as c
right outer join dealer as d on  d.id = c.dealer_id
left outer join sell as s on s.client_id = c.id
where s.amount >=2000 and c.priority is not NULL;
--2a
create view by_each_date
as select s.date ,count(distinct client_id),
          avg(s.amount) , sum(amount)
         from sell as s
        group by s.date order by s.date;
select * from by_each_date;
drop view by_each_date;
--2b
create view by_each_date
as select s.date , sum (s.amount)
    from sell as s
    group by s.date
    order by sum(s.amount) desc limit 5;
select * from by_each_date;
drop view by_each_date;
--2c
create view dealer_sell
as select s.dealer_id as dealer_id, count(dealer_id) as number_of_sales,avg(amount),sum(amount)
from sell as  s
group by s.dealer_id
order by s.dealer_id;
select * from dealer_sell;
drop view dealer_sell;
--2d
create view earn
as  select location,sum(final)
from (select d.location,sum(sell.amount) * d.charge as final
        from sell
            inner join dealer as d on d.id=sell.dealer_id
        group by d.location,d.charge) as l
group by location
having location = l.location;
select * from earn;
drop view earn;
--2e
create view in_each_city
as select d.location, count(s.id), sum(s.amount), avg(s.amount)
from sell as s
         inner join dealer as d on s.dealer_id = d.id
group by d.location;
select * from in_each_city;
drop view in_each_city;
--2f
create view in_each_city
as select c.city as city, count(c.city), sum(s.amount), avg(s.amount)
from client as c
         inner join sell as s on c.id = s.client_id
group by city;
select * from in_each_city;
drop view in_each_city;
--2g
create view expenses as
select city
from (select sum(s.amount) as sells, d.location
        from sell as s inner join dealer as d on s.dealer_id = d.id
      group by d.location) as exp
         inner join (select city, sum(s.amount) as exps
                     from client as c inner join sell as s on c.id = s.client_id
                     group by city) new on exps > sells
    and exp.location = new.city;
select * from  expenses;
drop view expenses;

-- drop table client;
-- drop table dealer;
-- drop table sell;
