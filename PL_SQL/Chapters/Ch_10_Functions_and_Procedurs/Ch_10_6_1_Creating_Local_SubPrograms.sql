/*
    A local subprogram is a procedure or function declared within another PL/SQL block.
    It is temporary in nature, cannot be called outside the block, and is not stored in the database.
    
    A local subprogram is:
        1. A procedure or function
        2. Declared inside another PL/SQL block
        3. NOT stored in the database
        4. Exists only during execution of the parent block
        
    Advantages: 
        1. Reduce Code Repitation.
        2. Improve Code Readability.
        3. Need no more privillage like (comes under schema).
        
    DisAdvantages:
        1. They are accessible only in the blocks they are defined.
*/


--CREATE TABLE emps_high_paid AS SELECT * FROM employees WHERE 1 = 2;
/

-- Way 1:
DECLARE
    FUNCTION get_emp (
        emp_num employees.employee_id%TYPE
    ) RETURN employees%rowtype IS
        emp employees%rowtype;
    BEGIN
        SELECT * INTO emp FROM employees WHERE employee_id = emp_num;
        RETURN emp;
    END;
    
    PROCEDURE insert_high_paid_emp (
        emp_id employees.employee_id%TYPE
    ) IS
        emp employees%rowtype;
    BEGIN
        emp := get_emp(emp_id);
        INSERT INTO emps_high_paid VALUES emp;

    END;
    
BEGIN
    FOR c_emp IN (SELECT * FROM employees) LOOP
        IF c_emp.salary > 15000 THEN
            insert_high_paid_emp(c_emp.employee_id);
        END IF;
    END LOOP;
END;
/


-- Way 2:
DECLARE
    PROCEDURE insert_high_paid_emp (
        emp_id employees.employee_id%TYPE
    ) IS

        emp employees%rowtype;

        FUNCTION get_emp (
            emp_num employees.employee_id%TYPE
        ) RETURN employees%rowtype IS
        BEGIN
            SELECT * INTO emp FROM employees WHERE employee_id = emp_num;
            RETURN emp;
        END;

    BEGIN
        emp := get_emp(emp_id);
        INSERT INTO emps_high_paid VALUES emp;

    END;

BEGIN
    FOR c_emp IN (
        SELECT * FROM employees
    ) LOOP
        IF c_emp.salary > 15000 THEN
            insert_high_paid_emp(c_emp.employee_id);
        END IF;
    END LOOP;
END;
/
select * from emps_high_paid;


-- If you try to execute belowe script it will throw error because it called an procedure that is present in another block. So it will
-- raise error
begin
execute immediate insert_high_paid_emp(101);
end;
/