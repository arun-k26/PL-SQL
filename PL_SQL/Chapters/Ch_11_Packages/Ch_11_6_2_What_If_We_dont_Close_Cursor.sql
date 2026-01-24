declare 
    v_emp employees%rowtype;
begin
    open constants_pkg.cur_emps;
    fetch constants_pkg.cur_emps into v_emp;
    dbms_output.put_line(v_emp.first_name);
    close constants_pkg.cur_emps;
end;
/

/*
    For the first time i opened my cursor and closed.
*/

declare 
    v_emp employees%rowtype;
begin
    open constants_pkg.cur_emps;
    fetch constants_pkg.cur_emps into v_emp;
    dbms_output.put_line(v_emp.first_name);
--    close constants_pkg.cur_emps;
end;
/


/*
    Here i kept it as open. Execute it you can see every execution new first_name as an result.
*/


