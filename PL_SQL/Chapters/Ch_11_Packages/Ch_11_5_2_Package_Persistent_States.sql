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


set serveroutput on
exec dbms_output.put_line(hr.constants_pkg.v_company_name);

/*
    Executed the above script after the hr schema v_company_name changed to 
    'Sandhiya Enterprises'. now it is showing the correct Value 'Oracle'.
    
    Because we have implemented the pragma serially_reusable in the package declaration.
    If you override the varible in the package means it will reflect in that particular package only because of we used the pragma serially_reusable.
*/


/*
    What if user calls continusly on that time what value my_user 
    see while the server call of hr user continues.
    It is impossible to run other code at the same time.But, we can
    sleep our code execution for som seconds.
    
    So we can use the sleep procedure of the dbms_lock package.
*/

grant execute on dbms_lock to hr;


set serveroutput on
begin
    constants_pkg.v_company_name := 'SANDHIYA ENTERPRISES';
    dbms_output.put_line(constants_pkg.v_company_name);
end;
/

