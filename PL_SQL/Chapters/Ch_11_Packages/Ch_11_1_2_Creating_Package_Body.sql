create or replace PACKAGE BODY emp AS

    PROCEDURE increase_salaries AS
    BEGIN
        FOR r1 IN cur_emps LOOP
            update employees_copy set salary = salary + v_salary_increase_rate;
        END LOOP;
    END increase_salaries;

    FUNCTION get_avg_sal (
        p_dept_id INT
    ) RETURN NUMBER AS
        v_avg_sal NUMBER := 0;
    BEGIN
        select avg(salary) into v_avg_sal from employees_copy where department_id = p_dept_id;
        RETURN v_avg_sal;
    END get_avg_sal;

END emp;