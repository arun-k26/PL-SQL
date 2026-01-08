DECLARE
    too_higher_salary EXCEPTION;
    v_salary_check PLS_INTEGER;
BEGIN
    SELECT salary INTO v_salary_check FROM employees WHERE employee_id = 100;

    IF v_salary_check > 20000 THEN
        RAISE too_higher_salary;
--    raise_application_error(-20243, 'The salary of the selected employees is too high!!!! please conside our situation');
    END IF;
    
    -- We raise our own exception if the salary is under 20000
    dbms_output.put_line('The salary is in acceptable range');
EXCEPTION
    WHEN too_higher_salary THEN
        dbms_output.put_line('This salary is too high. You need to decrease it');
        raise_application_error(-20243, 'The salary of the selected employees is too high!!!! please conside our situation',true);
--        raise_application_error(-20243, 'The salary of the selected employees is too high!!!! please conside our situation',false);

END;
/