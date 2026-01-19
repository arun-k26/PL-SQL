exec emp.increase_salaries;
/

set serveroutput on
begin
    dbms_output.put_line('Average : ' || emp.get_avg_sal(50));
    dbms_output.put_line('Average : ' || emp.v_salary_increase_rate);
end;
/