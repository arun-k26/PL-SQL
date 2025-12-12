--CREATE TABLE employees_copy AS SELECT * FROM employees;

SELECT
    *
FROM
    employees_copy;

DECLARE
    v_salary_increase NUMBER := 400;
BEGIN
    FOR i IN 207..216 LOOP
--        --INSERT    
--        INSERT INTO employees_copy (
--            employee_id,
--            first_name,
--            last_name,
--            email,
--            hire_date,
--            job_id,
--            salary
--        ) VALUES (
--            i,
--            'employee_id#' || i,
--            'temp_emp',
--            'abc@gmail.com',
--            sysdate,
--            'IT_PROG',
--            1000
--        );
        
        
        --UPDATE
        UPDATE employees_copy
        SET
            salary = salary + v_salary_increase
        WHERE
            employee_id = i;

    
        --DELETE

        DELETE FROM employees_copy
        WHERE
            employee_id = i;

    END LOOP;
END;