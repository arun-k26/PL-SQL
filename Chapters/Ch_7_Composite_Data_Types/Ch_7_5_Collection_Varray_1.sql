SET SERVEROUTPUT ON

DECLARE
    TYPE e_list IS
        VARRAY(5) OF VARCHAR2(20);
    employees e_list;
BEGIN
    employees := e_list('Sandhiya', 'Arunachalam', 'Kannan', 'Saraswathi', 'Gowtham');
    dbms_output.put_line(employees(1));
--    FOR i IN 1..5 LOOP                -- 1 way
--        for i in 1..employees.count() loop      -- 2nd way : .count() or .count
    FOR i IN employees.first..employees.last LOOP       -- 3rd way
     dbms_output.put_line('Index of '
                                                                       || i
                                                                       || ' : '
                                                                       || employees(i));
    END LOOP;

END;

-- EXISTS() METHOD

SET SERVEROUTPUT ON

DECLARE
    TYPE e_list IS
        VARRAY(5) OF VARCHAR2(20);
    employees e_list;
BEGIN
    employees := e_list('Sandhiya', 'Arunachalam', 'Kannan', 'Saraswathi', 'Gowtham');
    dbms_output.put_line(employees(1));
    FOR i IN 1..5 LOOP IF employees.EXISTS(i) THEN
        dbms_output.put_line('Index of '
                             || i
                             || ' : '
                             || employees(i));

    END IF;
    END LOOP;

END;

-- LIMIT() FUNCTION - it wll print the size of the collections

SET SERVEROUTPUT ON

DECLARE
    TYPE e_list IS
        VARRAY(5) OF VARCHAR2(20);
    employees e_list;
BEGIN
    employees := e_list('Sandhiya', 'Arunachalam', 'Kannan', 'Saraswathi', 'Gowtham');
    dbms_output.put_line(employees.limit());
END;


/*
    EXTENDS ---> EXTEND is used with Nested Tables and VARRAYs to increase the size of the collection by adding an empty element at the end.
    First it will create one empty one for our array then we can assign value to it.
            
*/
SET SERVEROUTPUT ON

DECLARE
--    TYPE e_list IS
--        VARRAY(15) OF VARCHAR2(50);           -- Open next file.....
    employees   e_list := e_list();
    idx         NUMBER := 1;
BEGIN
    FOR i IN 100..110 LOOP
        employees.extend;           
        SELECT
            first_name
        INTO
            employees
        (idx)
        FROM
            employees
        WHERE
            employee_id = i;

        idx := idx + 1;
    END LOOP;

    FOR i IN 1..employees.count() LOOP dbms_output.put_line('value of index '
                                                            || i
                                                            || ' : '
                                                            || employees(i));
    END LOOP;

END;


