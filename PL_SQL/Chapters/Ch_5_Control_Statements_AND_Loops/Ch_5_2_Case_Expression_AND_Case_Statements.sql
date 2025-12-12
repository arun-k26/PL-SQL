SET SERVEROUTPUT ON

DECLARE
    v_job_code          VARCHAR2(10) := 'IT_PROG';
    v_salary_increase   NUMBER;
    v_department        VARCHAR2(10) := 'IT';
BEGIN
    --Case Expressions
    v_salary_increase :=
        CASE
            WHEN v_job_code = 'SA_MAN' THEN
                0.2
            WHEN v_department = 'IT' AND v_job_code = 'IT_PROG' THEN
                0.3
            ELSE 0
        END;

    dbms_output.put_line('Your salary increase is : ' || v_salary_increase);
    
    
    --Case Statements
    CASE
        WHEN v_job_code = 'SA_MAN' THEN
            v_salary_increase := 0.2;
            dbms_output.put_line('Your salary increase for a sales manager is : ' || v_salary_increase);
        WHEN v_department = 'IT' AND v_job_code = 'IT_PROG' THEN
            v_salary_increase := 0.3;
            dbms_output.put_line('Your salary increase for a IT PROGRAMMER is : ' || v_salary_increase);
        ELSE
            v_salary_increase := 0;
            dbms_output.put_line('Your salary increase for this job_ID is : ' || v_salary_increase);
    END CASE;

    dbms_output.put_line('Your salary increase is : ' || v_salary_increase);
END;