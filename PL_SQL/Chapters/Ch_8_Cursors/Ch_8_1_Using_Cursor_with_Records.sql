/*
    For single or <5 you can use normal cursor is fine. But what if you want to fetch more than 10 or 20 columns. So, most of the time
    we use records for cursor.
    
    3 ways to do that.
        
*/

--  WAY 1
set serveroutput on
declare
    type r_emp is record (
        v_first_name            employees.first_name%TYPE,
        v_last_name             employees.last_name%TYPE,
        v_department_name       departments.department_name%TYPE
    );
    
    v_emp r_emp;
    cursor c_emps is select first_name, last_name, department_name from employees join departments using (department_id) where department_id between
    30 and 60;
    
begin
    open c_emps;
    fetch c_emps into v_emp;
    dbms_output.put_line('Rec 1 : ' || v_emp.v_first_name || '  ' || v_emp.v_last_name || ' dept_id : ' || v_emp.v_department_name);
    
    fetch c_emps into v_emp;
    dbms_output.put_line('Rec 2 : ' || v_emp.v_first_name || '  ' || v_emp.v_last_name || ' dept_id : ' || v_emp.v_department_name);
    close c_emps;
end;



--  WAY 2
set serveroutput on
declare
    v_emp employees%ROWTYPE;
    cursor c_emps is select first_name, last_name, department_id from employees join departments using (department_id) where department_id between
    30 and 60;
    
begin
    open c_emps;
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_emp.department_id;
    dbms_output.put_line('Rec 1 : ' || v_emp.first_name || '  ' || v_emp.last_name || ' dept_id : ' || v_emp.department_id);
    
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_emp.department_id;
    dbms_output.put_line('Rec 2 : ' || v_emp.first_name || '  ' || v_emp.last_name || ' dept_id : ' || v_emp.department_id);
    close c_emps;
end; 



--  WAY 3
set serveroutput on
declare
    
    cursor c_emps is select first_name, last_name, department_id from employees join departments using (department_id) where department_id between
    30 and 60;
    v_emp c_emps%ROWTYPE;
    
begin
    open c_emps;
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_emp.department_id;
    dbms_output.put_line('Rec 1 : ' || v_emp.first_name || '  ' || v_emp.last_name || ' dept_id : ' || v_emp.department_id);
    
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_emp.department_id;
    dbms_output.put_line('Rec 2 : ' || v_emp.first_name || '  ' || v_emp.last_name || ' dept_id : ' || v_emp.department_id);
    close c_emps;
end; 