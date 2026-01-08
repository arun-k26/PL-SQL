set serveroutput on 
declare
    cannot_update_null exception;
    pragma exception_init(cannot_update_null, -01407);
begin
    update employees_copy set email= null where employee_id=100;
    exception
        when cannot_update_null then 
            dbms_output.put_line('You cannot sandhiya with a null value');
end;
 