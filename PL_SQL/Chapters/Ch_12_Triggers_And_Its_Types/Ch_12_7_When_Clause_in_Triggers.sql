ALTER TABLE employees_copy DISABLE ALL TRIGGERS;
/

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER prevent_high_salary BEFORE
    INSERT OR UPDATE OF salary ON employees_copy
    FOR EACH ROW
    WHEN ( new.salary > 50000 )
BEGIN
    raise_application_error(-20006, 'A salary cannot by higher than 50000');
END;
/

UPDATE employees_copy
SET
    salary = 49999;