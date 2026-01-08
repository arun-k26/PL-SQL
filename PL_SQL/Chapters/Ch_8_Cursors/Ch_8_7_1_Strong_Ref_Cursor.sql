set serveroutput on
DECLARE

    --Way 1
--    TYPE t_emps IS REF CURSOR RETURN employees%rowtype;
--    rc_emps   t_emps;
--    r_emps    employees%rowtype; -- or r_emps    rc_emps%rowtype;
    
    --Way 2
    r_emps    employees%rowtype;
    TYPE t_emps IS REF CURSOR RETURN r_emps%type;
    rc_emps   t_emps;
    
BEGIN
    OPEN rc_emps FOR SELECT * FROM retired_employees;

    LOOP
        FETCH rc_emps INTO r_emps;
        EXIT WHEN rc_emps%notfound;
        dbms_output.put_line(r_emps.first_name || ' ' || r_emps.last_name);
    END LOOP;
    CLOSE rc_emps;
    
    dbms_output.put_line('-----------------------');
    
    OPEN rc_emps FOR SELECT * FROM employees where job_id='IT_PROG';

    LOOP
        FETCH rc_emps INTO r_emps;
        EXIT WHEN rc_emps%notfound;
        dbms_output.put_line(r_emps.first_name || ' ' || r_emps.last_name);
    END LOOP;
    CLOSE rc_emps;
END;
/