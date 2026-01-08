--  Example 1 : Normal Input as parameter
declare 
    cursor c_emp (p_dept_id number) is select first_name, last_name, department_name from employees join departments using (department_id) 
    where department_id = p_dept_id;
    
    v_emp c_emp%rowtype;
begin
    open c_emp (20);
    fetch c_emp into v_emp;
    dbms_output.put_line('The employees in the department of : ' || v_emp.department_name || ' are ');
    close c_emp;
    
    open c_emp (20);
        loop
            fetch c_emp into v_emp;
            exit when c_emp%notfound;
            dbms_output.put_line(v_emp.first_name || '  ' || v_emp.last_name);
        end loop;
    close c_emp;
end;



--  Example 2 : Bind variable as parameter
declare 
    cursor c_emp (p_dept_id number) is select first_name, last_name, department_name from employees join departments using (department_id) 
    where department_id = p_dept_id;
    
    v_emp c_emp%rowtype;
begin
    open c_emp (:bind_dept_id);
    fetch c_emp into v_emp;
    dbms_output.put_line('The employees in the department of : ' || v_emp.department_name || ' are ');
    close c_emp;
    
    open c_emp (:bind_dept_id);
        loop
            fetch c_emp into v_emp;
            exit when c_emp%notfound;
            dbms_output.put_line(v_emp.first_name || '  ' || v_emp.last_name);
        end loop;
    close c_emp;
end;



--  Example 3 : Bind variable with for loop
declare 
    cursor c_emp (p_dept_id number) is select first_name, last_name, department_name from employees join departments using (department_id) 
    where department_id = p_dept_id;
    
    v_emp c_emp%rowtype;
begin
    open c_emp (:bind_dept_id);
    fetch c_emp into v_emp;
    dbms_output.put_line('The employees in the department of : ' || v_emp.department_name || ' are ');
    close c_emp;
    
    open c_emp (:bind_dept_id);
        loop
            fetch c_emp into v_emp;
            exit when c_emp%notfound;
            dbms_output.put_line(v_emp.first_name || '  ' || v_emp.last_name);
        end loop;
    close c_emp;
    
    open c_emp (:bind_dept_id2);
    fetch c_emp into v_emp;
    dbms_output.put_line('The employees in the department of : ' || v_emp.department_name || ' are ');
    close c_emp;
    
    for i in c_emp (:bind_dept_id2) loop 
        dbms_output.put_line('Arun emps ' || i.first_name || '  ' || i.last_name);
    end loop;
end;



--  Example 3 : Multiple parameters 
declare 
    cursor c_emp1 (p_dept_id number, p_job_id varchar2) is select first_name, last_name, department_name, job_id from employees join departments 
    using (department_id) where department_id = p_dept_id and job_id = p_job_id;
    
    cursor c_emp2 (p_dept_id number, job_id varchar2) is select first_name, last_name, department_name, job_id from employees join departments 
    using (department_id) where department_id = p_dept_id and job_id = job_id;
begin 
    for i in c_emp1 (50, 'ST_MAN') loop 
        dbms_output.put_line(i.first_name || '  ' || i.last_name || ' - ' || i.job_id);
    end loop;
    dbms_output.put_line('************************************');
    
    /*
        c_emp2 this cursor will fetch entire data of that job_id. Because we declared parameter name as column name. So plsql and sql confuses 
        and so that it fetches the entire job_id data for that particular department_ID
        select * from employees where department_id=80;
    */
    for i in c_emp2 (80, 'SA_MAN') loop 
        dbms_output.put_line(i.first_name || '  ' || i.last_name || ' - ' || i.job_id);
    end loop;
end;

