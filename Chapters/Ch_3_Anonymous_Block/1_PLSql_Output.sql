--If you written dbms_output without SET SERVEROUTPUT ON it will not print output.
SET SERVEROUTPUT ON

DECLARE BEGIN
    dbms_output.put_line('HELLO ARUNCHALAM');
    dbms_output.put_line('HELLO ARUNCHALAM');
END;


