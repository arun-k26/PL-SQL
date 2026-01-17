SET SERVEROUTPUT ON

DECLARE
    v_emp employees%rowtype;
BEGIN
    dbms_output.put_line('Fetching the employee data!..');
    v_emp := get_emp(10);
    dbms_output.put_line('Some information of the employee are : ');
    dbms_output.put_line('The name of the employee is : ' || v_emp.first_name);
    dbms_output.put_line('The email of the employee is : ' || v_emp.email);
    dbms_output.put_line('The salary of the employee is : ' || v_emp.salary);
END;