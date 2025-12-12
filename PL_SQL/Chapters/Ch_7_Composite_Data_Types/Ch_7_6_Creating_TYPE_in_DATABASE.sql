--Way 1
-- We can create our type inside of declare. But it stores in memory when finishes its job then it will be erased.


-- WAY 2
-- We can create our type directly in the database. This type of creation is called 'SCHEMA-LEVEL TYPE'

--CREATE
create type e_list is varray(15) of varchar2(50);

--UPDATE
create or replace type e_list is varray(20) of varchar2(100);

--DROP
drop type e_list;