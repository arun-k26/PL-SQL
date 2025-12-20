-- We can not store record in database. But instead of record we can use the OBJECT to store the data in collection (varray and nested_table)
-- then we store the collection in database table.

-- USING NESTED TABLE


-- CREATE OBJECT
create or replace type t_phone_no as object (obj_ph_type varchar2(10), obj_ph_number varchar2(20));
/

-- CREATE VARRAY
create or replace type n_phone_no as table of t_phone_no;
/

-- CREATE TABLE
--    We are using nested table so we must store the nested table in the storage table with name

create table emp_with_phones_2 (emp_id number, f_name varchar2(50), l_name varchar2(50), n_ph_no n_phone_no) nested table n_ph_no store as n_ph_no_table;
/

--  INSERTING DATA
insert into emp_with_phones_2 values (101, 'ARUN', 'KUMAR', n_phone_no(t_phone_no('HOME', '7395999014'),t_phone_no('WORK', '8807720804'),
    t_phone_no('MOBILE', '8939754099')));
/

insert into emp_with_phones_2 values (102, 'SANDHIYA', 'ARUN', n_phone_no(t_phone_no('HOME', '6598656565'),t_phone_no('WORK', '7878454512')));
/

insert into emp_with_phones_2 values (103, 'GOWTHAM', 'ARUN', n_phone_no(t_phone_no('HOME', '6598656565'),
                                                                          t_phone_no('WORK', '7878454512'),
                                                                          t_phone_no('MOB1', '7878454512'),
                                                                          t_phone_no('MOB2', '7878454512'),
                                                                          t_phone_no('MOB3', '7878454512')));
                                                                          
update emp_with_phones_2 set n_ph_no = n_phone_no(t_phone_no('HOME', '6598656565'),
                                                                          t_phone_no('WORK', '1111111111'),
                                                                          t_phone_no('MOB1', '7878454512'),
                                                                          t_phone_no('MOB2', '7878454512'),
                                                                          t_phone_no('MOB3', '7878454512')) where emp_id=101;  

--  We can not see the collection values normally
select * from emp_with_phones;
select * from emp_with_phones_2;


/* 
    2 Ways we can see the values 
        1. Run Script (F5).
        2. We join our table with the array in it with using the table operator.
*/

select e.emp_id, e.f_name, e.l_name, p.obj_ph_type, p.obj_ph_number from emp_with_phones e, table(e.arr_ph_no) p;
select e.emp_id, e.f_name, e.l_name, p.obj_ph_type, p.obj_ph_number from emp_with_phones_2 e, table(e.n_ph_no) p;
