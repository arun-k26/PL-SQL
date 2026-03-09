/*
    A disabled trigger is stored in the database but inactive until enabled.
    Disabling the trigger is nothing but you will create a trigger and it is stored in the database. But it will not executed automatically.ALTER
    Example : You created a trigger. But you think we will test this trigger later on during the testing. So for till that time it will be disabled.ALTER
    You can enable the trigger whenever you want using the alter query.
*/

CREATE OR REPLACE TRIGGER prevent_high_salary BEFORE
    INSERT OR UPDATE OF salary ON employees_copy
    FOR EACH ROW
DISABLE
    WHEN ( new.salary > 5000 )
BEGIN
    raise_application_error(-20006, 'A salary cannot be higher than 50000!');
END;