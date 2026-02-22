SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER before_statment_emp_cpy BEFORE
    INSERT OR UPDATE ON employees_copy
BEGIN
    dbms_output.put_line('Before Statement Trigger is Fired');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER after_statment_emp_cpy AFTER
    INSERT OR UPDATE ON employees_copy
BEGIN
    dbms_output.put_line('After Statement Trigger is Fired');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER after_row_emp_cpy AFTER
    INSERT OR UPDATE ON employees_copy
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('After Row Trigger is Fired');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER before_row_emp_cpy BEFORE
    INSERT OR UPDATE ON employees_copy
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('Before Row Trigger is Fired');
END;
/


--- Checking the Created Trigger

SET SERVEROUTPUT ON

update employees_copy set salary = salary + 100 where employee_id = 100;  -- Record Exist
update employees_copy set salary = salary + 100 where employee_id = 99;   -- Record NOT Exist
update employees_copy set salary = salary + 100 where department_id = 30;   -- 6 Record Exist. So, 6 times before and after row trigger executes