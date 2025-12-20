create table employee_salary_hist as select * from employees where 1 = 2;
alter table employee_salary_hist add inserted_date date;
delete from employee_salary_hist;
select * from employee_salary_hist;
/

DECLARE
    TYPE e_list IS
        TABLE OF employee_salary_hist%rowtype INDEX BY PLS_INTEGER;
    emps   e_list;
    idx    PLS_INTEGER;
BEGIN
    FOR x IN 101..120 LOOP SELECT
                               e.*,
                               sysdate + ( x - 100 )
                           INTO
                               emps
                           (x)
                           FROM
                               employees e
                           WHERE
                               employee_id = x;

    END LOOP;

    idx := emps.first;
    WHILE idx IS NOT NULL LOOP
        emps(idx).salary := emps(idx).salary + emps(idx).salary * 0.5;

        INSERT INTO employee_salary_hist VALUES emps ( idx );

        dbms_output.put_line(emps(idx).first_name
                             || ' employee data updated in table');
        idx := emps.next(idx);
    END LOOP;

END;