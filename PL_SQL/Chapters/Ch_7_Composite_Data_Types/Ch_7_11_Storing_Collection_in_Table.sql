-- We can not store record in database. But instead of record we can use the OBJECT to store the data in collection (varray and nested_table)
-- then we store the collection in database table.

-- USING VARRAYS

-- CREATE OBJECT
create or replace type t_phone_no as object (obj_ph_type varchar2(10), obj_ph_number varchar2(20));
/

-- CREATE VARRAY
create or replace type v_phone_no as varray(3) of t_phone_no;
/

-- CREATE TABLE
create table emp_with_phones (emp_id number, f_name varchar2(50), l_name varchar2(50), arr_ph_no v_phone_no);
/

--  INSERTING DATA
insert into emp_with_phones values (101, 'ARUN', 'KUMAR', v_phone_no(t_phone_no('HOME', '7395999014'),t_phone_no('WORK', '8807720804'),
    t_phone_no('MOBILE', '8939754099')));
/

insert into emp_with_phones values (102, 'SANDHIYA', 'ARUN', v_phone_no(t_phone_no('HOME', '6598656565'),t_phone_no('WORK', '7878454512')));
/

--  We can not see the collection values normally
select * from emp_with_phones;


/* 
    2 Ways we can see the values 
        1. Run Script (F5).
        2. We join our table with the array in it with using the table operator.
*/

select e.emp_id, e.f_name, e.l_name, p.obj_ph_type, p.obj_ph_number from emp_with_phones e, table(e.arr_ph_no) p;
