-- We cannot use the both update and update of event in an same trigger
SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER prevent_updates_of_constant_columns BEFORE
    UPDATE OF hire_date, salary ON employees_copy
    FOR EACH ROW
BEGIN
    raise_application_error(-20005, 'You cannot modify the hire_date and salary columns!.....');
END;
/

update employees_copy set hire_date = sysdate;

update employees_copy set salary = 100;