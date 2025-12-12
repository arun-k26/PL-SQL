--create sequence employee_id_seq start with 207 increment by 1;
select * from employees_copy;

BEGIN
    FOR i IN 1..10 LOOP
--        --INSERT    
        INSERT INTO employees_copy (
            employee_id,
            first_name,
            last_name,
            email,
            hire_date,
            job_id,
            salary
        ) VALUES (
            employee_id_seq.nextval,
            'employee_id#' || employee_id_seq.nextval,
            'temp_emp',
            'abc@gmail.com',
            sysdate,
            'IT_PROG',
            1000
        );
      

    END LOOP;
END;




--EXAMPLE 2
DECLARE
    v_seq_num NUMBER;
BEGIN
    v_seq_num := employee_id_seq.nextval;
    dbms_output.put_line('Sequence no : ' || v_seq_num);
END;