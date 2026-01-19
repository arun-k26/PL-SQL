/*
    This is visible to others. This is called Public 
    3 types of object:
        1. Public - Declaring in the PACKAGE SPECIFICATION
        2. Private - Declaing inside the package body. call only inside the package alone.
        3. LOCAL_OBJECTS - Creating or declaring inside of the subprogram or procedure or function.
*/

create or replace package EMP_PKG as 
    v_salary_increase_rate number := 1322;
    cursor cur_emps is select * from employees;
    procedure increase_salaries;
    function get_avg_sal(p_dept_id int) return number;
end EMP_PKG;
/

create or replace PACKAGE BODY EMP_PKG AS
    v_sal_inc int := 500;
    v_sal_inc2 int := 500;
    
    /* 
        print_test -> This is an private procedure. you can call this procedure inside this package only. 
    other than outside you can not call this procedure. It will throw error. 
    */
    procedure print_test is
    begin
        dbms_output.put_line(v_salary_increase_rate);
    end;
    
    PROCEDURE increase_salaries AS
    BEGIN
        FOR r1 IN cur_emps LOOP
            update employees_copy set salary = salary + v_salary_increase_rate;
        END LOOP;
    END increase_salaries;

--    v_sal_inc2 int := 500;  -- This will throw error because private variables declared only on the top of the after the package is or as.
    
    FUNCTION get_avg_sal (
        p_dept_id INT
    ) RETURN NUMBER AS
        v_avg_sal NUMBER := 0;
    BEGIN
        print_test;
        select avg(salary) into v_avg_sal from employees_copy where department_id = p_dept_id;
        RETURN v_avg_sal;
    END get_avg_sal;

END EMP_PKG;
/


-- Calling Area

begin
    dbms_output.put_line(EMP_PKG.v_sal_inc);        --This will throw error due to private variable
end;
/

begin
    exec emp_pkg.print_test;    --This will throw error due to private procedure. You can call only inside of the package
end;
/

begin
    dbms_output.put_line(emp_pkg.get_avg_sal(50));
end;
/
