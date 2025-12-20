/*
    2nd COLLECTION
    Why we use nested_table instead of v_arrays. We can add after initilization also in nested_table. Because of that, we can use this instead
    of v_arrays
*/

-- Example : 1
declare 
    type e_list is table of varchar2(500);
    emps e_list;
begin
    emps := e_list('Alex', 'Alwar', 'Aalavandhan', 'Dasavadharam');
    emps.extend;
    emps(5) := 'SANDHIYA';          --  added new value here    
    for i in 1..emps.count loop
        dbms_output.put_line('index of ' || i || ' : ' || emps(i));
    
    end loop;
end;


-- Example : 2

declare 
    type e_list is table of varchar2(50);
    emps e_list := e_list();
    idx pls_integer := 1;
begin
    
    for i in 100..110 loop
        emps.extend;
        select first_name into emps(idx) from employees where employee_id = i;
        dbms_output.put_line('Fetched index of ' || idx || ' : ' || nvl(emps(idx),0));
        idx := idx + 1;
    end loop;
end;



-- Example : 3

declare 
    type e_list is table of employees.first_name%TYPE;
    emps e_list := e_list();
    idx pls_integer := 1;
begin
    
    for i in 100..110 loop
        emps.extend;
        select first_name into emps(idx) from employees where employee_id = i; 
        dbms_output.put_line('Fetched index of ' || idx || ' : ' || nvl(emps(idx),0));
        idx := idx + 1;
    end loop;
end;


/*
    WHY WE USE ASSOCIATIVE ARRAY INSTEAD OF NESTED_TABLE?????
        emps.delete(3);
        It will delete the record of index 3. But not allocate the new value in that index 3 area. So it will throw error  likr 'NO RECORD FOUND'.
        We can handle this error by using exists().
    
    BUT WHY WE USE NESTED TABLE ?
        We can store nested_table in the database but we can't store the  associative array.
*/

-- Example : 5

declare 
--    type e_list is table of employees.first_name%TYPE;    -- Because we stored this type in  database itself like v_arrays.
    emps e_list := e_list();
    idx pls_integer := 1;
begin
    
    for i in 100..110 loop
        emps.extend;
        select first_name into emps(idx) from employees where employee_id = i; 
        dbms_output.put_line('Fetched index of ' || idx || ' : ' || nvl(emps(idx),0));
        idx := idx + 1;
    end loop;
    
    emps.DELETE(3);
    for i in 1..emps.count loop 
        if emps.exists(i) then
            dbms_output.put_line('Fetched index of ' || i || ' : ' || emps(i)); 
        end if;
    end loop;
    
end;


--Example : 6
create or replace type e_list is table of varchar2(100);