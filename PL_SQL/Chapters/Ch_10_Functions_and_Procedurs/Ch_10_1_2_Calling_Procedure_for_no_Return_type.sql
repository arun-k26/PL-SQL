-- Way 1
execute increase_salaries;
/

-- Way 2
begin
    dbms_output.put_line('Increasing the salaries!!!!!');
    increase_salaries;
    increase_salaries;
    increase_salaries;
    increase_salaries;
    dbms_output.put_line('All the salaries are successfully increased!!!!!');
end;
/

-- Way 3 
begin
    dbms_output.put_line('Increasing the salaries!!!!!');
    increase_salaries;
    new_line;
    increase_salaries;
    new_line;
    increase_salaries;
    new_line;
    increase_salaries;
    dbms_output.put_line('All the salaries are successfully increased!!!!!');
end;
/