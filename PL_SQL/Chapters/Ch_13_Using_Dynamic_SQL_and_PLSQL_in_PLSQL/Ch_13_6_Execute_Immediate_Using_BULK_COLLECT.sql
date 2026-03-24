SET SERVEROUTPUT ON

DECLARE
    TYPE t_name IS
        TABLE OF VARCHAR2(20);
    names t_name;
BEGIN
    EXECUTE IMMEDIATE 'select distinct first_name from employees' BULK COLLECT
    INTO names;
    FOR i IN 1..names.count LOOP dbms_output.put_line(names(i));
    END LOOP;

END;
/

--------------------------------------------------------------------------------

CREATE TABLE employees_copy
    AS
        SELECT
            *
        FROM
            employees;

SET SERVEROUTPUT ON

DECLARE
    TYPE t_name IS
        TABLE OF VARCHAR2(20);
    names t_name;
BEGIN

    /*
        By the way, even if we use the bind variable we did not use the USING CLAUSE. 
            The reason is the placeholder after the RETURNING CLAUSE inside the dynamic SQL TEXT is not considered as BIND VARIABLE.
            They are returned into the variable we defined at the INTO CLAUSE.
    */
    EXECUTE IMMEDIATE 'update employees_copy set salary = salary + 1000 where department_id = 30 returning first_name into :a' RETURNING
    BULK COLLECT
    INTO names;
    FOR i IN 1..names.count LOOP dbms_output.put_line(names(i));
    END LOOP;

END;
/