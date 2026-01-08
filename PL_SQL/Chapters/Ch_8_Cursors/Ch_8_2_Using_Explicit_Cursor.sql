/*
    Oracle has two different engine.  1. SQL Engine 2. PL_SQL Engine. Inside the plsql block we use sql command. So with this plsql engine
        communicate with the sql engine to run this sql code and then return back the result to the plsql engine.
        
    So your sql command run in sql engine and the result is stored in PGA (PROGRAM GLOBAL AREA). Everu session will have its own memory when it
    is created. This is controlled only by Oracle. We can't control this flow.
    
    In Cursor, The query contains  crore records also, On the time of fetching the cursor it fetches the new record. It will not go back or 
    repeat the same row. It move forward and further only.
    In our code we manually written 2 fetches. So, it will fetch the first 2 rows of data only.
    
    The usage of Cursor:
        1. Declare    2. Open     3. Fetch    4. Check      5. Close
        
*/

--  EXAMPLE 1
set serveroutput on
declare
    cursor e_emps is select first_name, last_name, department_name from employees join departments using (department_id) where department_id between
    30 and 60;
    v_first_name            employees.first_name%TYPE;
    v_last_name             employees.last_name%TYPE;
    v_department_name       departments.department_name%TYPE;
begin
    open e_emps;
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    dbms_output.put_line('Rec 1 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    dbms_output.put_line('Rec 2 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    dbms_output.put_line('Rec 3 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    dbms_output.put_line('Rec 4 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    
    -- See the difference
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    dbms_output.put_line('Rec 5: ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    dbms_output.put_line('Rec 6 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    dbms_output.put_line('Rec 7 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    
    fetch e_emps into v_first_name, v_last_name, v_department_name;
    dbms_output.put_line('Rec 8 : ' || v_first_name || '  ' || v_last_name || ' dept_id : ' || v_department_name);
    
    close e_emps;
end;