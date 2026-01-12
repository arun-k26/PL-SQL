SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE print (
    text IN VARCHAR2
) AS
BEGIN
    dbms_output.put_line(text);
END;