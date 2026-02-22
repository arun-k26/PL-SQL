SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER before_row_emp_cpy BEFORE
    INSERT OR UPDATE OR DELETE ON employees_copy
    REFERENCING
            OLD AS o
            NEW AS n
    FOR EACH ROW        -- It is keyword to create ROW LEVEL TRIGGERS
BEGIN
    dbms_output.put_line('Before Row Trigger is Fired');
    dbms_output.put_line('BEFORE ROW LEVEL TRIGGER : The salary of Employee '
                         || :o.employee_id
                         || ' -> Before : '
                         || :o.salary
                         || ' After : '
                         || :n.salary);

    IF inserting THEN
        IF :n.hire_date > sysdate THEN
            raise_application_error(-20000, 'You cannot enter a future date');
        END IF;

        dbms_output.put_line('An insert occured on employees_copy table');
    ELSIF updating('salary') THEN
        IF :n.salary > 50000 THEN
            raise_application_error(-20002, 'A salary cannot be higher than 50000');
        END IF;

        dbms_output.put_line('An update occured on employees_copy table and salary column');
    ELSIF updating THEN
        dbms_output.put_line('An update occured on employees_copy table');
    ELSIF deleting THEN
        raise_application_error(-20001, 'You cannot delete from the employees_copy table');
        dbms_output.put_line('An delete occured on employees_copy table');
    END IF;

END;
/

-- CHECKING OUR TRIGGER

DELETE FROM employees_copy;

update employees_copy set salary = 60000;