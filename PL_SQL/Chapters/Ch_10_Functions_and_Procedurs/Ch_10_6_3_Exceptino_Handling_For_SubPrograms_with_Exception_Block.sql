CREATE OR REPLACE FUNCTION get_emp (
    emp_num employees.employee_id%TYPE
) RETURN employees%rowtype IS
    emp employees%rowtype;
BEGIN
    SELECT
        *
    INTO emp
    FROM
        employees
    WHERE
        employee_id = emp_num;

    RETURN emp;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('There is no employee with the id ' || emp_num);
        RAISE no_data_found;
    WHEN OTHERS THEN
        dbms_output.put_line('Something unexpected happened!.');
        RETURN NULL;
END;