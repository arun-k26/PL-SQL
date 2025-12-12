desc employees;

set serveroutput on
declare 
v_type_1    employees.job_id%TYPE;
v_type_2    v_type_1%TYPE;
begin
    v_type_1  := 'IT_PROG';
    v_type_2  := 'SA_MON';
    dbms_output.put_line(v_type_1);
    dbms_output.put_line(v_type_2);
end;
