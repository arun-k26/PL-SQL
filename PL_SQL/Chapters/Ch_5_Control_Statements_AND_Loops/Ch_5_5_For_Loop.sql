BEGIN
    --0 to n
    FOR i IN 1..3 LOOP dbms_output.put_line('My counter o to N is : ' || i);
    END LOOP;

    dbms_output.put_line('***********************************');
    
    --n to 0
    FOR i IN REVERSE 1..3 LOOP dbms_output.put_line('My counter N to 0 is : ' || i);
    END LOOP;

END;