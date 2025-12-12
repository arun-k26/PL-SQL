SET SERVEROUTPUT ON

DECLARE
    r_emp employees%rowtype;            -- This is 1st type in RECORDS. We get the type directly from the table.
BEGIN
    SELECT
        *
    INTO r_emp
    FROM
        employees
    WHERE
        employee_id = '101';

    r_emp.salary := 200;        -- We can manipulate the data
    dbms_output.put_line(r_emp.first_name
                         || ' '
                         || r_emp.last_name
                         || ' earns : '
                         || r_emp.salary
                         || ' and hired on : '
                         || r_emp.hire_date);

END;