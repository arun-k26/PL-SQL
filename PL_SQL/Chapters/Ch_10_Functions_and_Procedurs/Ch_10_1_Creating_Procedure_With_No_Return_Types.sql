CREATE OR REPLACE PROCEDURE increase_salaries AS

    CURSOR c_emps IS
    SELECT
        *
    FROM
        employees_copy
    FOR UPDATE;

    v_salary_increase   PLS_INTEGER := 1.10;
    v_old_salary        PLS_INTEGER;
BEGIN
    FOR r_emps IN c_emps LOOP
        v_old_salary := r_emps.salary;
        r_emps.salary := r_emps.salary * v_salary_increase + r_emps.salary * nvl(r_emps.commission_pct, 0);

        UPDATE employees_copy
        SET
            row = r_emps
        WHERE
            CURRENT OF c_emps;

        dbms_output.put_line('The salary of : '
                             || r_emps.employee_id
                             || ' is increased from '
                             || v_old_salary
                             || ' to '
                             || r_emps.salary);

    END LOOP;
END;
/