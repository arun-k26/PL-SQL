/*
    1. Is should be a valid PLSQL block.
    2. It should finish with a semicolon.
    3. It can access only global objects.
    4. Exceptions should be handled outside of the dynamic PLSQL block.
*/
BEGIN
    FOR r_emps IN (
        SELECT
            *
        FROM
            employees
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
    END LOOP;
END;
/

-----------------------------------------------------------

-- Now we are executing the same above block in execute immediate

SET SERVEROUTPUT ON

DECLARE
    v_dynamic_text VARCHAR2(2000);
BEGIN
    v_dynamic_text := q'[BEGIN
    FOR r_emps IN (
        SELECT * FROM employees
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
    END LOOP;
END;]'
    ;
    EXECUTE IMMEDIATE v_dynamic_text;
END;

-------------------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE
    v_dynamic_text VARCHAR2(2000);
--    v_department_id pls_integer := 30;  -- SELECT * FROM employees where department_id = v_department_id 
--    if written like this in block this will throw error. Istead of this you can directly add this in block.
BEGIN
    v_dynamic_text := q'[
    declare 
        v_department_id pls_integer := 30;
    BEGIN
    FOR r_emps IN (
        SELECT * FROM employees where department_id = v_department_id
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
    END LOOP;
END;]'
    ;
    EXECUTE IMMEDIATE v_dynamic_text;
END;

----------------------------------------------------------------------------------

-- Way 3

CREATE OR REPLACE PACKAGE pkg_temp AS
    v_department_id_pkg PLS_INTEGER := 50;
END pkg_temp;

SET SERVEROUTPUT ON

DECLARE
    v_dynamic_text VARCHAR2(2000);
--    v_department_id pls_integer := 30;  -- SELECT * FROM employees where department_id = v_department_id 
--    if written like this in block this will throw error. Istead of this you can directly add this in block.
BEGIN
    v_dynamic_text := q'[ 
    BEGIN
    FOR r_emps IN (
        SELECT * FROM employees where department_id = pkg_temp.v_department_id_pkg
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
    END LOOP;
END;]'
    ;
    EXECUTE IMMEDIATE v_dynamic_text;
END;

----------------------------------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE
    v_dynamic_text    VARCHAR2(2000);
    v_department_id   PLS_INTEGER := 30;
BEGIN
    v_dynamic_text := q'[ 
    BEGIN
    FOR r_emps IN (
        SELECT * FROM employees where department_id = :1
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
    END LOOP;
END;]'
    ;
    EXECUTE IMMEDIATE v_dynamic_text
        USING v_department_id;
END;

----------------------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE
    v_dynamic_text    VARCHAR2(2000);
    v_department_id   PLS_INTEGER := 30;
    v_max_salary      PLS_INTEGER := 0;
BEGIN
    v_dynamic_text := q'[ 
    BEGIN
    FOR r_emps IN (
        SELECT * FROM employees where department_id = :1
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
        if r_emps.salary > :sal then
            :sal := r_emps.salary;
        end if;
    END LOOP;
END;]'
    ;
    EXECUTE IMMEDIATE v_dynamic_text
        USING v_department_id, IN OUT v_max_salary;
    dbms_output.put_line('The maximum salary of this department is : ' || v_max_salary);
END;

-----------------------------------------------------------------------------------------

-- We should handle the exception block for the execute immediate block in the outside of it.

SET SERVEROUTPUT ON

DECLARE
    v_dynamic_text    VARCHAR2(2000);
    v_department_id   PLS_INTEGER := 30;
    v_max_salary      PLS_INTEGER := 0;
BEGIN
    v_dynamic_text := q'[ 
    BEGIN
    FOR r_emps IN (
        SELECT * FROM employeess where department_id = :1
    ) LOOP
        dbms_output.put_line(r_emps.first_name
                             || ' '
                             || r_emps.last_name);
        if r_emps.salary > :sal then
            :sal := r_emps.salary;
        end if;
    END LOOP;
END;]'
    ;
    EXECUTE IMMEDIATE v_dynamic_text
        USING v_department_id, IN OUT v_max_salary;
    dbms_output.put_line('The maximum salary of this department is : ' || v_max_salary);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(' The error is : ' || sqlerrm);
END;
/

DROP PACKAGE pkg_temp;
/