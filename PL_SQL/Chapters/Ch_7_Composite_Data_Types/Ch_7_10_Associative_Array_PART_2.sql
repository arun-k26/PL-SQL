--  Example : 5     -> USING %ROWTYPE RECORD

set serveroutput on
declare 
    type e_list is table of employees%ROWTYPE index by employees.email%TYPE;
    emps e_list;
    idx employees.email%TYPE;
begin 
    for i in 101..110 loop
        select * into emps(i) from employees where employee_id=i;
    end loop; 
    
    idx := emps.first;
    while idx is not null loop
        dbms_output.put_line('The email of : ' || emps(idx).first_name || '  ' || emps(idx).last_name || ' is : ' || idx);
        idx := emps.next(idx);
    end loop;
end;
/ 



--  Example : 6     -> USING OUR OWN CUSTOMIZED RECORD

SET SERVEROUTPUT ON

DECLARE
    TYPE emp_rec IS RECORD (
        first_name    employees.first_name%TYPE,
        last_name     employees.last_name%TYPE,
        employee_id   employees.employee_id%TYPE
    );
    TYPE v_emp_rec IS
        TABLE OF emp_rec INDEX BY PLS_INTEGER;
    v_emp_rec_data   v_emp_rec;
    idx              employees.email%TYPE;
BEGIN
    FOR i IN 101..110 LOOP
        SELECT
            first_name,
            last_name,
            employee_id
        INTO
            v_emp_rec_data
        (i)
        FROM
            employees
        WHERE
            employee_id = i;

        dbms_output.put_line('My name is : '
                             || v_emp_rec_data(i).first_name
                             || ' '
                             || v_emp_rec_data(i).last_name
                             || ' employee_id : '
                             || v_emp_rec_data(i).employee_id);

    END LOOP;  
END;
/



--  Example : 7     -> USING delete(), When you use PRIOR() inside a loop, you can iterate a collection in reverse order.

set serveroutput on
declare 
    type e_list is table of employees%ROWTYPE index by employees.email%TYPE;
    emps e_list;
    idx employees.email%TYPE;
begin 
    for i in 101..110 loop
        select * into emps(i) from employees where employee_id=i;
    end loop; 
    
    emps.delete(101,102);   
    idx := emps.last;
    while idx is not null loop
        dbms_output.put_line('The email of : ' || emps(idx).first_name || '  ' || emps(idx).last_name || ' is : ' || idx);
        idx := emps.prior(idx);
    end loop;
end;
/ 