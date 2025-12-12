SET SERVEROUTPUT ON

SET AUTOPRINT ON

SET TIMING ON

VARIABLE var_text VARCHAR2(30);

VARIABLE var_number NUMBER;

DECLARE
    v_text     VARCHAR2(30);
    v_number   NUMBER;
BEGIN
    :var_text := 'Hello Sandhiya';
    :var_number := 69;
    v_text := :var_text;
    v_number := :var_number;
    dbms_output.put_line(v_text);
    dbms_output.put_line(:var_text);
END;
/

PRINT var_text;