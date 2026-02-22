/*
    NEW and OLD QUALIFIERS Works only in ROW LEVEL TRIGGER. If you try this in Statement Level Trigger it will throw an error.
*/
ALTER TABLE employees_copy DISABLE ALL TRIGGERS;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER before_row_emp_cpy BEFORE
    INSERT OR UPDATE ON employees_copy
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('Before Row Trigger is Fired');
    dbms_output.put_line('BEFORE ROW LEVEL TRIGGER : The salary of Employee '
                         || :old.employee_id
                         || ' -> Before : '
                         || :old.salary
                         || ' After : '
                         || :new.salary);

END;
/

-- Checking Old and New is printing or not by triggers

UPDATE employees_copy
SET
    salary = salary + 100
WHERE
    department_id = 30;

--- Now checking this in After Row Trigger

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER after_row_emp_cpy AFTER
    INSERT OR UPDATE ON employees_copy
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('After Row Trigger is Fired');
    dbms_output.put_line('AFTER ROW LEVEL TRIGGER : The salary of Employee '
                         || :old.employee_id
                         || ' -> Before : '
                         || :old.salary
                         || ' After : '
                         || :new.salary);

END;
/

UPDATE employees_copy
SET
    salary = salary + 100
WHERE
    department_id = 30;

-- We update out before_row_emp trigger to add delete event also

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER before_row_emp_cpy BEFORE
    INSERT OR UPDATE OR DELETE ON employees_copy
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('Before Row Trigger is Fired');
    dbms_output.put_line('BEFORE ROW LEVEL TRIGGER : The salary of Employee '
                         || :old.employee_id
                         || ' -> Before : '
                         || :old.salary
                         || ' After : '
                         || :new.salary);

END;
/

DELETE FROM employees_copy; -- Before values will print but after values will be null. Because there is not after anymore.

INSERT INTO employees_copy
    SELECT
        *
    FROM
        employees; -- Before values will be null but after values will print. Because there is no values in the table before.

--- NOW CHECKING FOR AFTER ROW LEVEL TRIGGER

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER after_row_emp_cpy AFTER
    INSERT OR UPDATE OR DELETE ON employees_copy
    REFERENCING
            OLD AS o
            NEW AS n
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('After Row Trigger is Fired');
    dbms_output.put_line('AFTER ROW LEVEL TRIGGER : The salary of Employee '
                         || :o.employee_id
                         || ' -> Before : '
                         || :o.salary
                         || ' After : '
                         || :n.salary);

END;
/

DELETE FROM employees_copy; -- Before values will print but after values will be null. Because there is not after anymore.

INSERT INTO employees_copy
    SELECT
        *
    FROM
        employees; -- Before values will be null but after values will print. Because there is no values in the table before.