--Example 1 : Normal Infinite loop
set serveroutput on
declare 
    cursor c_emp is select * from employees where department_id='30';
    v_emp c_emp%rowtype;
begin
    open c_emp;
        loop
            fetch c_emp into v_emp;
            exit when c_emp%notfound;
            dbms_output.put_line('Emp_ID : ' || v_emp.EMPLOYEE_ID || ' Emp_Name : ' || v_emp.first_name || '' || v_emp.last_name);
        end loop;
    close c_emp;
end;



--Example 2 : While loop
/*
    For  the while loop you are using for cursor means before the loop you must fetch your cursor atleast once. After that only you should
    go inside of the loop. and for while loop we have special function called cursor_name%found then.
*/

set serveroutput on
declare 
    cursor c_emp is select * from employees where department_id='30';
    v_emp c_emp%rowtype;
begin
    open c_emp;
    fetch c_emp into v_emp;
        while c_emp%found loop
            dbms_output.put_line('Emp_ID : ' || v_emp.EMPLOYEE_ID || ' Emp_Name : ' || v_emp.first_name || ' ' || v_emp.last_name);
            fetch c_emp into v_emp;
        end loop;
    close c_emp;
end;



--Example 3 : For loop
set serveroutput on
declare 
    cursor c_emp is select * from employees where department_id=    '30';
begin
    for i in c_emp loop
        dbms_output.put_line('Emp_ID : ' || i.EMPLOYEE_ID || ' Emp_Name : ' || i.first_name || ' - ' || i.last_name);
    end loop;
end;



--Example 4 : For loop
begin
    for i in (select * from employees where department_id='30') loop
        dbms_output.put_line('Emp_ID : ' || i.EMPLOYEE_ID || ' Emp_Name : ' || i.first_name || ' - ' || i.last_name);
    end loop;
end;