/*

    Conditional Predictds :
        2 WAYS:
            Instead of creating trigger for all 3(insert, update, delete) events, you can easily make 3 different triggers with the same
            timing and different event.
            But creating 3 triggers is not a good choice. So to restrict this we can use the CONDITIONAL TRIGGER BY WHEN CLAUSE

*/
ALTER TABLE employees_copy DISABLE ALL TRIGGERS;
/

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
        dbms_output.put_line('An insert occured on employees_copy table');
    ELSIF updating('salary') THEN
        dbms_output.put_line('An update occured on employees_copy table and salary column');
    ELSIF updating THEN
        dbms_output.put_line('An update occured on employees_copy table');
    ELSIF deleting THEN
        dbms_output.put_line('An delete occured on employees_copy table');
    END IF;

END;
/

UPDATE employees_copy SET salary = salary + 100 WHERE department_id = 30; -- for salay column update trigger condition

DELETE FROM employees_copy;

INSERT INTO employees_copy SELECT * FROM employees;

UPDATE employees_copy SET commission_pct = 0.1 WHERE department_id = 30; -- for all update trigger condition