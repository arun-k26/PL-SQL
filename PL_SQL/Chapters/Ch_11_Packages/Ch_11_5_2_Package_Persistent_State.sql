/*
    If you check the package persiste. log 2 different users. I am using HR and my_user.
    This is our first usage. So these variables stored in the PGA rightnow.
*/


set serveroutput on
exec dbms_output.put_line(constants_pkg.v_salary_increase);
--grant execute on constants_pkg to my_user;
--revoke execute on constants_pkg from my_user;

/*
    Now its the time to see the persistent state of the variable.
*/
set serveroutput on
begin
    constants_pkg.v_salary_increase := 5;
    dbms_output.put_line(constants_pkg.v_salary_increase);
end;
/


create or replace PACKAGE constants_pkg AS
    v_salary_increase constant NUMBER := 0.04;
    CURSOR cur_emps IS
    SELECT * FROM employees;

    t_emps_type employees%rowtype;
    v_company_name VARCHAR2(20) := 'ORACLE';
END constants_pkg;
/


set serveroutput on
begin
    constants_pkg.v_salary_increase := 5;
    dbms_output.put_line(constants_pkg.v_salary_increase);
end;
/

-- It will throw error because we setted as constant we cant change.

create or replace PACKAGE constants_pkg AS pragma SERIALLY_REUSABLE;
    v_salary_increase constant NUMBER := 0.04;
    CURSOR cur_emps IS
    SELECT * FROM employees;

    t_emps_type employees%rowtype;
    v_company_name VARCHAR2(20) := 'ORACLE';
END constants_pkg;
/

set serveroutput on
exec dbms_output.put_line(constants_pkg.v_company_name);

set serveroutput on
begin
    constants_pkg.v_company_name := 'SANDHIYA ENTERPRISES';
    dbms_output.put_line(constants_pkg.v_company_name);
    dbms_lock.sleep(20);
end;
/


/*
    This will hold the execution for custimzied time frame.
*/  