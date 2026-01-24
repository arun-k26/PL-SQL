create table logs (log_source varchar2(200), log_message varchar2(4000), log_date date);


create or replace PACKAGE BODY emp_pkg AS
    v_sal_inc    INT := 500;
    v_sal_inc2   INT := 500;

    /* 
        This package will go and insert to the logs table for the first time calling only. If you executed one time means, again you call the 
        same package procedure ,function, other objects it wont execute the entire body of the package. It only executes only one time
        when the package was freshly connected when your databse is connected.
    */

--    FUNCTION get_sal (
--        e_id employees.employee_id%TYPE
--    ) RETURN NUMBER;       -- Here we declary the function by Forward Declaration

    PROCEDURE print_test IS
    BEGIN
        dbms_output.put_line('Test : ' || v_sal_inc);
--        dbms_output.put_line('Test Salary : ' || get_sal(102));
    END;

PROCEDURE increase_salaries AS
    BEGIN FOR r1 IN cur_emps LOOP
            update employees_copy set salary = salary + v_salary_increase_rate;

 end loop;
END increase_salaries;

--    v_sal_inc2 int := 500;  -- This will throw error because private variables declared only on the top of the after the package is or as.
    FUNCTION get_avg_sal (
        p_dept_id INT
    ) RETURN NUMBER AS
        v_avg_sal NUMBER := 0;
    BEGIN
        print_test;
--        select avg(salary) into v_avg_sal from employees_copy where department_id = p_dept_id;
        RETURN v_avg_sal;
    END get_avg_sal;
    
    begin
        v_salary_increase_rate := 6969;
        insert into logs values('EMP_PKG', 'Package Initialized!!', sysdate);    
END emp_pkg;
/

set serveroutput on
exec dbms_output.put_line(emp_pkg.get_avg_sal(80));
/


select * from logs;


set serveroutput on
exec dbms_output.put_line(emp_pkg.v_salary_increase_rate);
/