CREATE TABLE department_copy
    AS
        SELECT
            *
        FROM
            departments;
/

CREATE OR REPLACE VIEW vw_emp_details AS
    SELECT
        upper(department_name) dname,
        MIN(salary) min_sal,
        MAX(salary) max_sal
    FROM
        employees_copy
        JOIN department_copy USING ( department_id )
    GROUP BY
        department_name;
/

/*
    IF the view without aggregate functions, JOIN GROUP BY DISTINCT Aggregates (SUM, COUNT) UNION Calculated fields means it will allow DML. 
    IF the view contains these thing which i was explained now, then u need to use the INSTEAF OF TRIGGERS.
    
    when you try to update the view means it will throw error due to views. For the view DML operates on the only by INSTEAD OF TRIGGERS.
*/

-- Creating Trigger

CREATE OR REPLACE TRIGGER emp_details_vw_dml INSTEAD OF
    INSERT OR UPDATE OR DELETE ON vw_emp_details
    FOR EACH ROW
DECLARE
    v_dept_id PLS_INTEGER;
BEGIN
    IF inserting THEN
        SELECT
            MAX(department_id) + 10
        INTO v_dept_id
        FROM
            department_copy;

        INSERT INTO department_copy VALUES (
            v_dept_id,
            :new.dname,
            NULL,
            NULL
        );

    ELSIF deleting THEN
        DELETE FROM department_copy
        WHERE
            upper(department_name) = upper(:old.dname);

    ELSIF updating THEN
        UPDATE department_copy
        SET
            department_name = :new.dname
        WHERE
            upper(department_name) = upper(:new.dname);

    ELSE
        raise_application_error(2000, 'You cannot update any data other than department name!...');
    END IF;
END;
/


-- Executing the DML for our created instead of trigger

update vw_emp_details set dname = 'EXEC_DEPT' where upper(dname) = 'EXECUTIVE';

select * from department_copy;

select * from vw_emp_details;

insert into vw_emp_details values ('Execution', null, null);