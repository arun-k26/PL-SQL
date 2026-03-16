/*

    1. What is Mutating Table Error?
        A mutating table error occurs when a row level trigger tries to read or modify the same table that is currently being47
        modified by the triggering DML STATEMENTS.
        
        The table is currently beinf modified (insert, update, delete) and oracle does not allow the trigger to read it at the same time.
        
        Oracle can not guarantee:
            1. Which rows are already updated.
            2. Which rows are not updated.
            3. The correct result of the query.
        So, the oracle will return an error if an existing table is queried or modified again inside of the related trigger.
        
    2. A mutating table is :
        A table that being modifed by DML Operations.
        A table might be updated with the DELETE CASCADE.
    
    3. Row level triggers cannot be query or modify a mutating table.
    
    4. This restriction prevents the inconsistent data changes.
    
    5. Views being modified by the instead of triggers are not considered as mutating.
    
    6. We can handle mutating table error with a couple ways:
        1. Store related data in a another table.
        2. Store raleted data in a package.
        3. Use Compound Triggers.
    
*/

-- Creating Mutating Table Error Trigger to understand this
CREATE OR REPLACE TRIGGER trg_mutating_emps BEFORE
    INSERT OR UPDATE ON employees_copy
    FOR EACH ROW
DECLARE
    v_interval     NUMBER := 15;
    v_avg_salary   NUMBER;
BEGIN
    SELECT
        AVG(salary)
    INTO v_avg_salary
    FROM
        employees_copy
    WHERE
        department_id = :new.department_id;

    IF :new.salary > v_avg_salary + v_avg_salary * v_interval / 100 THEN
        raise_application_error(-20005, 'A raise cannot be '
                                        || v_interval
                                        || ' percent higher than its department''s average!!!');
    END IF;

END;
/

-- Diabling every trigger for this table except the current trigger. Because we are going to test with this trigger.

ALTER TABLE employees_copy DISABLE ALL TRIGGERS;

-- Testing the trigger by doing DML, but it throws error as expected

UPDATE employees_copy
SET
    salary = salary + 1000
WHERE
    employee_id = '154';