SET SERVEROUTPUT ON

DECLARE
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10 LOOP
        dbms_output.put_line('My counter is : ' || v_count);
        v_count := v_count + 1;
--        EXIT WHEN v_count = 3;      -- (OPTIONAL)
    END LOOP;
END;