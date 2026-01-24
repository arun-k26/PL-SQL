/*
    This schema does not have the permission to access the hr schema.
    So. We give access to use the my_user in hr schema.
    grant execute on constants_pkg to my_user;
    revoke execute on constants_pkg from my_user;
*/
set serveroutput on
exec dbms_output.put_line(hr.constants_pkg.v_salary_increase);

/*
    I executed the above statement after the hr schema exexution. 
    HR schema shows it as updated value but in my_user schema it still remains 0.04.
    So, generally public variables and object stored in the PGA for public specification.
    We are going to change that only.
*/

set serveroutput on
begin
    hr.constants_pkg.v_salary_increase := 3;
    dbms_output.put_line(hr.constants_pkg.v_salary_increase);
end;

/*
    The value will remain live until our session. This scenario happens because of our Public spec uses the PGA for memory
    if you disconnect and reconnnect in both schemas displays the 0.04 value in the package by default.
*/