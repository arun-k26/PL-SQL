/*
    What is Compound Trigger?
        1. Compound triggers allow you to create more than one timing statement of a trigger into a single trigger body.
        
            Instead of writting seperate triggers like :
                1. Before Statement
                2. Before Each Row Statement
                3. After Statement
                4. After Each Row Statement
            You can write all of them in a single trigger.
        2. You can store the variable throughout the trigger.
        
    COMPOUND TRIGGER RESTRICTIONS :
        1. Compound trigger must be a DML trigger defined on a table or view.
        2. A Compound trigger body must be compound trigger block.
        3. A Compound trigger body cannot have an initialization block.
        4. :OLD and :NEW cannot be used in the declaration or before or after statement.
        5. Firing order of compound trigger is not guaranteed if your don't use the follow clause.
*/

-- Creating Trigger
CREATE OR REPLACE TRIGGER trg_comp_emps FOR
    INSERT OR UPDATE OR DELETE ON employees_copy
COMPOUND TRIGGER
    v_dml_type VARCHAR2(10);
    BEFORE STATEMENT IS BEGIN
        IF inserting THEN
            v_dml_type := 'INSERT';
        ELSIF updating THEN
            v_dml_type := 'UPDATE';
        ELSIF deleting THEN
            v_dml_type := 'DELETE';
        END IF;

        dbms_output.put_line('Before statement section is executed  with the '
                             || v_dml_type
                             || ' event!!');
    END BEFORE STATEMENT;
    BEFORE EACH ROW IS
        x NUMBER;
    BEGIN
        dbms_output.put_line('Before Each row statement section is executed  with the '
                             || v_dml_type
                             || ' event!!');
    END BEFORE EACH ROW;
    AFTER EACH ROW IS BEGIN
        dbms_output.put_line('After Each row statement section is executed  with the '
                             || v_dml_type
                             || ' event!!');
    END AFTER EACH ROW;
    AFTER STATEMENT IS BEGIN
        dbms_output.put_line('After statement section is executed  with the '
                             || v_dml_type
                             || ' event!!');
    END AFTER STATEMENT;
END;
/

-- Testing the created Trigger : TRG_COMP_EMPS

SET SERVEROUTPUT ON

DELETE FROM employees_copy
WHERE
    department_id = 30;
/
    
    
-- Another Trigger example

CREATE OR REPLACE TRIGGER trg_comp_emps_cpy FOR
    INSERT OR UPDATE OR DELETE ON employees_copy
COMPOUND TRIGGER
    TYPE t_avg_dept_salaries IS
        TABLE OF employees_copy.salary%TYPE INDEX BY PLS_INTEGER;
    avg_dept_salaries t_avg_dept_salaries;
    BEFORE STATEMENT IS BEGIN
        FOR avg_sal IN (
            SELECT
                AVG(salary) salary,
                nvl(department_id, 999) department_id
            FROM
                employees_copy
            GROUP BY
                department_id
        ) LOOP avg_dept_salaries(avg_sal.department_id) := avg_sal.salary;
        END LOOP;

        dbms_output.put_line('Before statement section is executed');
    END BEFORE STATEMENT;
    AFTER EACH ROW IS
        v_interval NUMBER := 15;
    BEGIN
        IF :new.salary > avg_dept_salaries(:new.department_id) + avg_dept_salaries(:new.department_id) * v_interval / 100 THEN
            raise_application_error(-20005, 'A raise cannot be '
                                            || v_interval
                                            || ' percent higher than its department''s average');
        END IF;

        dbms_output.put_line('After Each row statement section is executed ');
    END AFTER EACH ROW;
    AFTER STATEMENT IS BEGIN
        dbms_output.put_line('All the changes are done successfully');
    END AFTER STATEMENT;
END;
/

-- Testing the created Trigger : trg_comp_emps_cpy

SET SERVEROUTPUT ON

UPDATE employees_copy
SET
    salary = salary + 5
WHERE
    employee_id = '154';