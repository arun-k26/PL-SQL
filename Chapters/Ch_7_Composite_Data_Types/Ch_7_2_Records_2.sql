SET SERVEROUTPUT ON

DECLARE
    --2nd Type in RECORDS
    TYPE t_emp IS RECORD (
        first_name   VARCHAR2(50),
        last_name    employees.last_name%TYPE,
        salary       employees.salary%TYPE,
        hire_date    employees.hire_date%TYPE
    );  
    
    /*  Now this is just an skeletone or declaration. Not yet we created a our own type. 
        We just declared our type. We need to initialize it
    */
    
    -- Variable creation for our type
    r_emp t_emp;
BEGIN
    SELECT
        first_name,
        last_name,
        salary,
        hire_date
    INTO r_emp
    FROM
        employees
    WHERE
        employee_id = '101';

            --   OR         
    -- We can manipulate the data
--    r_emp.first_name := 'SANDHIYA';
--    r_emp.last_name := 'ARUNACHALAM';
--    r_emp.salary := 200;
--    r_emp.hire_date := '01/01/2025';

    dbms_output.put_line(r_emp.first_name
                         || ' '
                         || r_emp.last_name
                         || ' earns : '
                         || r_emp.salary
                         || ' and hired on : '
                         || r_emp.hire_date);

END;