--Ex: 10_2_1
SET SERVEROUTPUT ON

BEGIN
    print('SALARY INCREASE STARTED');
    increase_salaries(1.5, 90);
    print('SALARY INCREASE STARTED');
END;
/


--Ex : 10_2_3
SET SERVEROUTPUT ON

DECLARE
    v_sal_inc         NUMBER := 1.2;
    v_aff_emp_count   NUMBER;
BEGIN
    print('SALARY INCREASE STARTED');
    increase_salaries(v_sal_inc, 80, v_aff_emp_count);
    print('The affected employee count is : ' || v_aff_emp_count);
    print('The average salary increase is '
          || v_sal_inc
          || ' percent!!...');
    print('SALARY INCREASE FINISHED!');
END;
/


--Ex : 10_2_4
exec print('10');
exec print(null);   --null is considered as value in procedure inpur.
exec print();
/


--Ex : 10_2_4_2
exec add_job('IT_DIR', 'IT Director', 5000, 20000);
exec add_job('IIT_DIR', 'IIT Director', 5000);
exec add_job('IT_DIR1', 'IT Director');


select * from jobs;

