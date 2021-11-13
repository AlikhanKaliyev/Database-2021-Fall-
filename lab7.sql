--2.1
create role accountant;
create role administrator;
create role support;

grant select,insert,delete on accounts,transactions to accountant;
grant all privileges  on accounts,customers,transactions to administrator;
grant update,insert,delete on customers,transactions to support;

--2.2
create user Alikhan;
grant accountant to Alikhan;
create user MagaLezgin;
grant support to MagaLezgin;
create user Olzhas;
grant administrator to Olzhas;

--2.3

create user mylord;
grant all privileges on accounts,transactions,customers to mylord with grant option ;

--2.4

revoke all privileges on accounts,transactions,customers from mylord;

--3.2

alter table customers alter column id set not null;
alter table customers alter column name set not null;
alter table customers alter column birth_date set not null;
alter table transactions alter column date set not null;
alter table transactions alter column src_account set not null;
alter table transactions alter column dst_account set not null;
alter table transactions alter column status set not null;
alter table accounts alter column account_id set not null;
alter table accounts alter column customer_id set not null;
alter table accounts alter column currency set not null;

--5.1

create index customer_account_currency on accounts (customer_id,account_id,currency);

--5.2

create index currency_balance on accounts (currency,balance);

--6

do
$$
    declare
        balance_ int;
        limit_ int;
    begin
        update accounts
        set balance = balance - 400
        where account_id = 'RS88012';
        update accounts
        set balance = balance + 400
        where account_id = 'RS88012';
        select balance into balance_ from accounts where account_id = 'RS88012';
        select "limit" into limit_  from accounts where account_id = 'RS88012';
        if balance_ > limit_ then
            update transactions set status='commited' where transactions.id=3;
        else
            commit;
            update transactions set status='rollback' where transactions.id=3;
        end if;
    end;
$$
