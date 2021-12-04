--1a
create or replace function plus1(x integer)
returns integer as $$
begin
    return x+1;
end;
$$
language PLPGSQL;

select plus1(1);

--1b

create or replace function summ(x integer,y integer)
returns integer as $$
begin
    return x+y;
end;
$$
language PLPGSQL;

select summ(2,5);

--1c
create or replace function div_2(x integer)
returns boolean as $$
begin
    return x%2=0;
end;
$$
language PLPGSQL;

select div_2(5);
select div_2(4);

--1d
create or replace function check_password(s varchar(255))
returns boolean as $$
begin
    if (length(s)<8) then
        RAISE EXCEPTION 'invalid password';
    end if;

    return true;
end;
$$
language PLPGSQL;

select check_password('hiOlzhas');
select check_password('Olzhas');

--1e
create or replace function product_and_sum(a integer,out _product varchar(255), out _sum varchar(255))
as $$
begin
    _product = 2*a;
    _sum = a*a;
end;
$$
language PLPGSQL;

select product_and_sum(5);

--2a

CREATE TABLE emp (
    empname text,
    salary integer,
    last_date timestamp,
    last_user text
);

CREATE FUNCTION emp_stamp() RETURNS trigger AS $emp_stamp$
    BEGIN
        -- Проверить, что указаны имя сотрудника и зарплата
        IF NEW.empname IS NULL THEN
            RAISE EXCEPTION 'empname cannot be null';
        END IF;
        IF NEW.salary IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.empname;
        END IF;

        -- Кто будет работать, если за это надо будет платить?
        IF NEW.salary < 0 THEN
            RAISE EXCEPTION '% cannot have a negative salary', NEW.empname;
        END IF;

        -- Запомнить, кто и когда изменил запись
        NEW.last_date := current_timestamp;
        NEW.last_user := current_user;
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp
    FOR EACH ROW EXECUTE FUNCTION emp_stamp();

insert into emp (empname, salary)
values ('lol',20000);
--2b
create table lel (
  name varchar(255),
  date_of_birth date,
  age integer
);
CREATE OR replace FUNCTION _age() RETURNS trigger AS $emp_stamp$
    BEGIN
        NEW.age :=2021 - extract(year from NEW.date_of_birth);
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;
CREATE TRIGGER _age BEFORE INSERT OR UPDATE ON lel
    FOR EACH ROW EXECUTE FUNCTION _age();
insert into lel(name,date_of_birth)
values('Alikhan','2002-07-08');

--2c
create table items (
  product_name varchar(255),
  cost numeric,
  tax numeric
);
CREATE OR replace FUNCTION taxi() RETURNS trigger AS $emp_stamp$
    BEGIN
        NEW.tax :=NEW.cost * 0.12;
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;
CREATE TRIGGER taxi BEFORE INSERT OR UPDATE ON items
    FOR EACH ROW EXECUTE FUNCTION taxi();
insert into items (product_name, cost)
values ('milk',10000);
insert into items (product_name, cost)
values ('dog',15000);

--2d

CREATE OR replace FUNCTION _error() RETURNS trigger AS $emp_stamp$
    BEGIN
        RAISE EXCEPTION 'you cannot';
    END;
$emp_stamp$ LANGUAGE plpgsql;
CREATE TRIGGER nodeletion before delete on items
FOR EACH ROW EXECUTE FUNCTION _error();
delete from items where product_name='milk';

--2e
create  table exam(
  name varchar(255),
  password varchar(255),
  number1 integer,
  isValid boolean,
  function1e varchar(255)
);
drop table example;
CREATE OR replace FUNCTION lolo() RETURNS trigger AS $emp_stamp$
    BEGIN
        new.isValid= check_password(new.password);
        new.function1e = product_and_sum(new.number1);
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;
CREATE TRIGGER lolo BEFORE INSERT OR UPDATE ON exam
    FOR EACH ROW EXECUTE FUNCTION lolo();
insert into exam(name, password, number1)
values ('Olzhas','abc1234ф',2);

--3
-- 1)1)Used mainly to execute certain business logic with DML and DRL statements
--   2)Used mainly to perform some computational process and returning the result of that process.
-- 2)1)Procedure can return zero or more values as output.
--   2)Function can return only single value as output
-- 3)1)Procedure cannot call with select statement, but can call from a block or from a procedure
--   2)Function can call with select statement , if function doesnot contain any DML statements and DDL statements..
-- function with DML and DDL statements can call with select statement with some special cases (using Pragma autonomous transaction)
-- 4)1)OUT keyword is used to return a value from procedure
--   2)RETURN keyword is used to return a value from a function.
-- 5)1)It is not mandatory to return the value
--   2)It is mandatory to return the value
-- 6)1)RETURN will simply exit the control from subprogram
--   2)RETURN will exit the control from subprogram and also returns the value
-- 7)1)Return datatype will not be specified at the time of creation
--   2)Return datatype is mandatory at the time of creation
--4a
create table company(
    id integer,
    name varchar(255),
    date_of_birth date,
    age integer,
    salary integer,
    work_experience integer,
    discount integer
);

CREATE or replace PROCEDURE insert_data(id integer, name varchar(255),date_of_birth date,age integer,salary integer,work_experience integer)
LANGUAGE plpgsql
AS $$
declare
    discount int;

begin
    discount = 10;
    salary = salary *pow(1.1 , work_experience/2);
    if work_experience > 5 then
        discount = discount + 1 ;
    end if;
    insert into company values(id,name,date_of_birth,age,salary,work_experience,discount);
end;
$$;

call insert_data(2,'bek','2002-07-08',39,5000,20);

--4b
create table company2(
    id integer,
    name varchar(255),
    date_of_birth date,
    age integer,
    salary integer,
    work_experience integer,
    discount integer
);

CREATE or replace PROCEDURE insert_data2(id integer, name varchar(255),date_of_birth date,age integer,salary integer,work_experience integer)
LANGUAGE plpgsql
AS $$
declare
    discount int;

begin
    discount = 10;
    salary = salary *pow(1.1 , work_experience/2);
    if(work_experience>5) then
        discount = discount+1;
    end if;
    if age >= 40 then
        salary = salary*1.15;
    end if;
    if(work_experience>8) then
        discount = 20;
        salary = salary*1.15;
    end if;
    insert into company2 values(id,name,date_of_birth,age,salary,work_experience,discount);
end;
$$;

call insert_data2(2,'beka','1970-07-08',51,5000,5);

--5
create table members (
  memid integer,
  surname varchar(200),
  firstname varchar(200),
  address varchar(300),
  zipcode integer,
  telephone varchar(20),
  recommendedby integer,
  joindate timestamp
);

create table bookings(
  facid integer,
  memid integer,
  starttime timestamp,
  slots integer
);
create table facilities(
  facid integer,
  name varchar(100),
  membercost numeric,
  guestcost numeric,
  initialoutloy numeric,
  monthlymaintenance numeric
);

with recursive recommenders(recommender, member) as (
	select recommendedby, memid
		from members
	union all
	select mems.recommendedby, recs.member
		from recommenders recs
		inner join members mems
			on mems.memid = recs.recommender
)
select recs.member member, recs.recommender, mems.firstname, mems.surname
	from recommenders recs
	inner join members mems
		on recs.recommender = mems.memid
	where recs.member = 22 or recs.member = 12
order by recs.member asc, recs.recommender desc
