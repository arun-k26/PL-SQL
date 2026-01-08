alter session set container = ORCLPDB;

create user my_user identified by admin;

grant create session to my_user;
grant select any table to my_user;
grant update on hr.employees_copy to my_user;
grant update on hr.departments to my_user;