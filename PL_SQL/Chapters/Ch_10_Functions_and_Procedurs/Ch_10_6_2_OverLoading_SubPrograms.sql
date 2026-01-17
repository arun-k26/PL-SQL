/*
    Overloading subprogram is normal and look like java - Method Overloading. There is nothing different in it.
*/
DECLARE
    PROCEDURE insert_high_paid_emp (
        p_emp employees%rowtype
    ) IS

        emp employees%rowtype;

        FUNCTION get_emp (
            emp_num employees.employee_id%TYPE
        ) RETURN employees%rowtype IS
        BEGIN
            SELECT
                *
            INTO emp
            FROM
                employees
            WHERE
                employee_id = emp_num;

            RETURN emp;
        END;

        FUNCTION get_emp (
            emp_email employees.email%TYPE
        ) RETURN employees%rowtype IS
        BEGIN
            SELECT
                *
            INTO emp
            FROM
                employees
            WHERE
                email = emp_email;

            RETURN emp;
        END;

        FUNCTION get_emp (
            f_name   employees.first_name%TYPE,
            l_name   employees.last_name%TYPE
        ) RETURN employees%rowtype IS
        BEGIN
            SELECT
                *
            INTO emp
            FROM
                employees
            WHERE
                first_name = f_name
                AND last_name = l_name;

            RETURN emp;
        END;

    BEGIN
        emp := get_emp(p_emp.employee_id);
        INSERT INTO emps_high_paid VALUES emp;

        emp := get_emp(p_emp.email);
        INSERT INTO emps_high_paid VALUES emp;

        emp := get_emp(p_emp.first_name, p_emp.last_name);
        INSERT INTO emps_high_paid VALUES emp;

    END;

BEGIN
    FOR c_emp IN (
        SELECT
            *
        FROM
            employees
    ) LOOP
        IF c_emp.salary > 15000 THEN
            insert_high_paid_emp(c_emp);
        END IF;
    END LOOP;
END;
/

SELECT
    *
FROM
    emps_high_paid;