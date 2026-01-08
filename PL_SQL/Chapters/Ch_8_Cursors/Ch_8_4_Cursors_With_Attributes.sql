declare
    cursor c_emp is select * from employees where department_id=50;
    v_emp c_emp%rowtype;
begin
    if not c_emp%isopen then
        open c_emp;
        dbms_output.put_line('Sandhiya');
    end if;

    dbms_output.put_line(c_emp%rowcount);
    fetch c_emp into v_emp;
    dbms_output.put_line(c_emp%rowcount);
    dbms_output.put_line(c_emp%rowcount);
    fetch c_emp into v_emp;
    dbms_output.put_line(c_emp%rowcount);
    close c_emp;
    
    open c_emp;
        loop
            fetch c_emp into v_emp;
            exit when c_emp%notfound or c_emp%rowcount > 5;
            dbms_output.put_line(c_emp%rowcount || '  ' || v_emp.first_name || '  ' || v_emp.last_name);
        end loop;
    close c_emp;
end;