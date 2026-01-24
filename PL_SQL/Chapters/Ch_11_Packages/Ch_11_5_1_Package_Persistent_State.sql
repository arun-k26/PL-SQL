/*
    If you check the package persiste. log 2 different users. I am using HR and my_user.
    This is our first usage. So these variables stored in the PGA rightnow.
*/


set serveroutput on
exec dbms_output.put_line(constants_pkg.v_salary_increase);
--grant execute on constants_pkg to my_user;
--revoke execute on constants_pkg from my_user;

/*
    Now its the time to see the persistent state of the variable.
*/
set serveroutput on
begin
    constants_pkg.v_salary_increase := 5;
    dbms_output.put_line(constants_pkg.v_salary_increase);
end;

