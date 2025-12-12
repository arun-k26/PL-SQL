SET SERVEROUTPUT ON

DECLARE
--  VARCHAR2
    v_text_1        VARCHAR2(50);
--    v_text_2 VARCHAR2(50) NOT NULL;         --now it will throw error when its null so assign value to it.
    v_text_2        VARCHAR2(50) NOT NULL := 'SANDHIYA';
    v_text_3        VARCHAR2(50) NOT NULL DEFAULT 'HELLO';
    v_text_4        VARCHAR2(50) NOT NULL DEFAULT 'HELLO';
    
    
--    NUMBER
    v_num_1         NUMBER(2) := 50;
    v_num_2         NUMBER(2) := 50.24;           -- when u set decimal value in number datatype it does not care about the decimal value. it neglects it
    v_num_3         NUMBER(4, 2) := 50.24;
    
    
--    BINARY_INTEGER or PLS_INTEGER
--    v_pls_int_1   PLS_INTEGER NOT NULL := 200;         -- PLS_INTEGER == BINARY_INTEGER
    v_pls_int_1     BINARY_INTEGER NOT NULL := 200;
    v_pls_int_2     BINARY_FLOAT NOT NULL := 200.25f;
    v_pls_int_3     BINARY_DOUBLE NOT NULL := 200.25887946523132;
    

--     DATE
    v_date          DATE := sysdate;
    

--     TIMESTAMP
    v_timestamp_1   TIMESTAMP NOT NULL := systimestamp;      -- This will show milliseconds also
    v_timestamp_2   TIMESTAMP(3) WITH TIME ZONE NOT NULL := systimestamp;
    
    
--     INTERVAL DAY(P) TO SECOND()
--      DAY(4) ? up to 4-digit days (max 9999 days)
--      SECOND(2) ? 2 decimal places of seconds
    v_day_1         INTERVAL DAY ( 4 ) TO SECOND ( 2 ) := '24 02:05:21.012';
--    24 days
--    2 hours
--    5 minutes
--    21.012 seconds
    
    
--     INTERVAL YEAR(3) TO MONTH
    v_day_2         INTERVAL YEAR ( 3 ) TO MONTH := '122-3';
--    Up to 3-digit years (max 999 years)
--    122 years
--    3 months

--      BOOLEAN
    v_bool          BOOLEAN := true;
BEGIN
    v_text_4 := 'PL/SQL' || ' Course';
    dbms_output.put_line(v_text_1);
    dbms_output.put_line(v_text_2);
    dbms_output.put_line(v_text_3);
    dbms_output.put_line(v_text_4 || ' BEGINNER TO ADVANCED');
    dbms_output.put_line(v_num_1);
    dbms_output.put_line(v_num_2);
    dbms_output.put_line(v_num_3);
    dbms_output.put_line(v_pls_int_1);
    dbms_output.put_line(v_pls_int_2);
    dbms_output.put_line(v_pls_int_3);
    dbms_output.put_line(v_date);
    dbms_output.put_line(v_timestamp_1);
    dbms_output.put_line(v_timestamp_2);
    dbms_output.put_line(v_day_1);
    dbms_output.put_line(v_day_2);
    dbms_output.put_line(v_bool);
END;