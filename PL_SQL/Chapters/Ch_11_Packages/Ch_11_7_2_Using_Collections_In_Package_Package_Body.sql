CREATE OR REPLACE PACKAGE BODY emp_pkg AS

    PRAGMA serially_reusable;
    v_sal_inc    INT := 500;
    v_sal_inc2   INT := 500;

    /* 
        print_test -> This is an private procedure. you can call this procedure inside this package only. 
    other than outside you can not call this procedure. It will throw error. 
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
    BEGIN
        FOR r1 IN cur_emps LOOP
            UPDATE employees_copy
            SET
                salary = salary + v_salary_increase_rate;

        END LOOP;
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

 
    /*
        This function returns all the employees of employees table in an associative array.
    */

    FUNCTION get_employees RETURN emp_table_type IS
        v_emps emp_table_type;
    BEGIN
        FOR cur_emps IN (
            SELECT
                *
            FROM
                employees_copy
        ) LOOP v_emps(cur_emps.employee_id) := cur_emps;
        END LOOP;

        RETURN v_emps;
    END;

    /*
        This function returns the employees whose salaries are under the minimum salary of the company standard.
    */

    FUNCTION get_employees_tobe_incremented RETURN emp_table_type IS
        v_emps   emp_table_type;
        i        employees.employee_id%TYPE;
    BEGIN
        v_emps := get_employees;
        i := v_emps.first;
        WHILE i IS NOT NULL LOOP
            IF v_emps(i).salary > v_min_employee_salary THEN
                v_emps.DELETE(i);
            END IF;

            i := v_emps.next(i);
        END LOOP;

        RETURN v_emps;
    END;

    /*
        This function returns the employee by arranging the salary based on the company standard.
    */

    FUNCTION arrange_for_min_salary (
        v_emp IN OUT employees%rowtype
    ) RETURN employees%rowtype AS
    BEGIN
    
        /* INPUT PARAMETERS are ready only purpose if you override with your wish means it will throw error.*/
        v_emp.salary := v_emp.salary + v_salary_increase_rate;
        IF ( v_emp.salary < v_min_employee_salary ) THEN
            v_emp.salary := v_min_employee_salary;
        END IF;

        RETURN v_emp;
    END;

    /*
        This procedure increase the salaries of the employees who has a lower salary than the company standard
    */

    PROCEDURE increase_low_salaries IS
        v_emps   emp_table_type;
        v_emp    employees%rowtype;
        i        employees.employee_id%TYPE;
    BEGIN
        v_emps := get_employees_tobe_incremented;
        i := v_emps.first;
        WHILE i IS NOT NULL LOOP
            v_emp := arrange_for_min_salary(v_emps(i));
            UPDATE employees_copy
            SET
                row = v_emp
            WHERE
                employee_id = i;

            i := v_emps.next(i);
        END LOOP;

    END;

BEGIN
    v_salary_increase_rate := 6969;
    INSERT INTO logs VALUES (
        'EMP_PKG',
        'Package Initialized!!',
        sysdate
    );

END emp_pkg;