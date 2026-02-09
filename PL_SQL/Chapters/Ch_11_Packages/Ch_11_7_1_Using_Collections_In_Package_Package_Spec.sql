CREATE OR REPLACE PACKAGE emp_pkg AS
    PRAGMA serially_reusable;
    TYPE emp_table_type IS
        TABLE OF employees%rowtype INDEX BY PLS_INTEGER;
    v_salary_increase_rate NUMBER := 100;
    v_min_employee_salary NUMBER := 5000;
    CURSOR cur_emps IS
    SELECT
        *
    FROM
        employees;

    PROCEDURE increase_salaries;

    FUNCTION get_avg_sal (
        p_dept_id INT
    ) RETURN NUMBER;

    FUNCTION get_employees RETURN emp_table_type;

    FUNCTION get_employees_tobe_incremented RETURN emp_table_type;

    PROCEDURE increase_low_salaries;

    /*
        We commented below function. now we declared it as private so below function present only in body. If some one see spec means
        they dont know we used below function or not. now we made the function as private so we maintain the order top to bottom order like
        an java program.
    */

--    FUNCTION arrange_for_min_salary (
--        v_emp IN OUT employees%rowtype
--    ) RETURN employees%rowtype;

END emp_pkg;