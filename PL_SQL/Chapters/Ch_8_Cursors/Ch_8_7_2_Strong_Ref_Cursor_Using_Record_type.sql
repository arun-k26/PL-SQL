set serveroutput on DECLARE
    TYPE ty_emps IS RECORD (
        e_id              NUMBER,
        first_name        employees.first_name%TYPE,
        last_name         employees.last_name%TYPE,
        department_name   departments.department_name%TYPE
    );
    r_emps    ty_emps;
    TYPE t_emps IS REF CURSOR RETURN ty_emps;
    rc_emps   t_emps;
    
BEGIN     
    OPEN rc_emps FOR SELECT employee_id,first_name,last_name,department_name FROM employees join departments using (department_id);

    LOOP
        FETCH rc_emps INTO r_emps;
        EXIT WHEN rc_emps%notfound;
        dbms_output.put_line(r_emps.first_name || ' ' || r_emps.last_name || ' is at the department of ' || r_emps.department_name);
    END LOOP;

CLOSE rc_emps;
END;
/

/*
    If you want to use the cursor query dynamically means you have choose the weak cursor. Strong cursor does not support dynamic cursor query.      
*/