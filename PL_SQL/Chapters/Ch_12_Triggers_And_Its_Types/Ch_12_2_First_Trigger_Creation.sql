CREATE OR REPLACE TRIGGER first_trigger BEFORE
    INSERT OR UPDATE ON employees_copy
--    REFERENCING
--            OLD AS xx
--            NEW AS yy         -- This is OPTIONAL
BEGIN
    dbms_output.put_line('An insert or update occured in the employees_copy table!....');
END;
/

SET SERVEROUTPUT ON;

BEGIN
    UPDATE employees_copy SET salary = salary + 100;
END;
/