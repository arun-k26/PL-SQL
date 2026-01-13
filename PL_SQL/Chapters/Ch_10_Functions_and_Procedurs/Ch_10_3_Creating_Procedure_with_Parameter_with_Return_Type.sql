CREATE OR REPLACE PROCEDURE increase_salaries (
    v_salary_increase   IN    NUMBER,
    v_department_id     IN    PLS_INTEGER,
    v_affected_count    OUT   NUMBER
) AS

    CURSOR c_emps IS
    SELECT
        *
    FROM
        employees_copy
    WHERE
        department_id = v_department_id
    FOR UPDATE;

--    v_salary_increase   PLS_INTEGER := 1.10;

    v_old_salary   NUMBER;
    v_sal_inc      NUMBER := 0;
BEGIN
    v_affected_count := 0;
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

        v_affected_count := v_affected_count + 1;
        v_sal_inc := v_sal_inc + v_salary_increase + nvl(r_emps.commission_pct, 0);
    END LOOP;

END;
/