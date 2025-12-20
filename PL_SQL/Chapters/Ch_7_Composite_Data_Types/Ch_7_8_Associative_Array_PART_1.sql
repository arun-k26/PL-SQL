/*
    1. Keys can be string and it should be unique.
    2. We don't have to initialize the associative array because it is already unbounded.
    3. Each value stored in an associative array is kept in memory along with a key (index), and PL/SQL uses that key to directly locate the value.
    
*/


--  Example : 1
set serveroutput on
declare 
    type e_list is table of employees.first_name%TYPE index by PLS_INTEGER;
    emps e_list;
begin 
    for i in 101..110 loop
        select first_name into emps(i) from employees where employee_id=i;
        dbms_output.put_line('VAlue of : ' || emps(i));
    end loop;
end;
/


--  Example : 2

set serveroutput on
declare 
    type e_list is table of employees.first_name%TYPE index by PLS_INTEGER;
    emps e_list;
begin 
    emps(110) := 'BOB';
    emps(120) := 'ARUN';

    /*
        This loop will throws error as "NO DATA FOUND". Because in the loop starts from 110 to 120. But we have only two values. and their
        key is 110 and 120. But after 110 there is no key like 111,112,... This is the reason it throws error. 
        
        To restrict this by exists(). But this is not the actual solution. We use while loop instead of for loop.
        
        if you print i instead of emps(i). it will not throw any error
        
        
    */

--    for i in 110..120 loop
--        dbms_output.put_line('VAlue of : ' || emps(i));
--    end loop;
    
    for i in 110..120 loop
        if emps.exists(i) then
        dbms_output.put_line('VAlue of : ' || emps(i));
        
        end if;
    end loop;
end;
/


--  Example : 3     -> USING WHILE LOOP

set serveroutput on
declare 
    type e_list is table of employees.first_name%TYPE index by PLS_INTEGER;
    emps e_list;
    idx pls_integer;
begin 
    for i in 101..110 loop
        select first_name into emps(i) from employees where employee_id=i;
--        dbms_output.put_line('VAlue of : ' || emps(i));
    end loop;
    idx := emps.first;
    
    while idx is not null loop
        dbms_output.put_line('VAlue of : ' || emps(idx));
        idx := emps.next(idx);
    end loop;
end;
/



--  Example : 3     -> Storing email as : KEY

set serveroutput on
declare 
    type e_list is table of employees.first_name%TYPE index by varchar2(100);
    emps e_list;
    idx employees.email%TYPE;
    v_first_name employees.first_name%TYPE;
begin 
    for i in 101..110 loop
        select first_name, email into v_first_name, idx from employees where employee_id=i;
        emps(idx) := v_first_name;
    end loop;
    
    
    idx := emps.first;
    while idx is not null loop
        dbms_output.put_line('The email of : ' || emps(idx) || ' is : ' || idx);
        idx := emps.next(idx);
    end loop;
end;
/ 
