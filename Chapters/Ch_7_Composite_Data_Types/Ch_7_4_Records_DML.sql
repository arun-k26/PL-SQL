create table retired_employees as select * from employees where 1 = 2;
select * from retired_employees;

DECLARE
    r_emp employees%rowtype;
    
begin
    select * into r_emp from employees where employee_id='104';
    r_emp.salary := 321;
    r_emp.commission_pct := 0;
--    insert into retired_employees values r_emp;
    update retired_employees set row = r_emp where employee_id='104';
end;

-- row is the keyword used to call the records. row is equal to records. This will update all the columns of the related row with the values
-- of our record.

--delete from retired_employees;