CREATE OR REPLACE PACKAGE emp_pkg AS
    v_salary_increase_rate NUMBER := 1322;
    cursor cur_emps is select * from employees;
    PROCEDURE increase_salaries;

    FUNCTION get_avg_sal (
        p_dept_id INT
    ) RETURN NUMBER;

END emp_pkg;
/

CREATE OR REPLACE PACKAGE BODY emp_pkg AS
    v_sal_inc    INT := 500;
    v_sal_inc2   INT := 500;
    
    /* 
        print_test -> This is an private procedure. you can call this procedure inside this package only. 
    other than outside you can not call this procedure. It will throw error. 
    */
    
    FUNCTION get_sal (
        e_id employees.employee_id%TYPE
    ) RETURN NUMBER;       -- Here we declary the function by Forward Declaration

    PROCEDURE print_test IS
    BEGIN
        dbms_output.put_line('Test : ' || v_sal_inc);
        dbms_output.put_line('Test Salary : ' || get_sal(102));
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

    -- get_sal() definitedly raise error due to this procediure should be in top of the page but it is located here.
    FUNCTION get_sal (
        e_id employees.employee_id%TYPE
    ) RETURN NUMBER AS
        v_sal NUMBER := 0;
    BEGIN
        SELECT salary INTO v_sal FROM employees WHERE employee_id = e_id;
        return v_sal;
    END;

END emp_pkg;
/

 
