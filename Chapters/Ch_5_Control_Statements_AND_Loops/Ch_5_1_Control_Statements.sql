SET SERVEROUTPUT ON

DECLARE
    v_num    NUMBER := 5;
    v_name   VARCHAR2(30) := 'Carol';
BEGIN
    IF v_num < 10 AND v_name = 'Carol' THEN
        dbms_output.put_line('HI!!!!!!!');
        dbms_output.put_line('I am smaller than 10');
    ELSIF v_num < 20 THEN
        dbms_output.put_line('I am smaller than 20');
    ELSIF v_num < 30 THEN
        dbms_output.put_line('I am smaller than 30');
    ELSE
        IF v_num IS NULL THEN
            dbms_output.put_line('The number is null');
        ELSE
            dbms_output.put_line('I am equal or greater than 30');
        END IF;
    END IF;
END;