SET SERVEROUTPUT ON

BEGIN
    << outer >>         -- This is called label. a label is a name you give to a block or loop
     DECLARE
--    v_outer VARCHAR2(50) := 'Outer!';
        v_text VARCHAR2(30) := 'OUT-Text';
    BEGIN
        DECLARE
--        v_innner VARCHAR2(50) := 'Inner Variable';
            v_text VARCHAR2(30) := 'In-Text';
        BEGIN
--        dbms_output.put_line('inner -> ' || v_outer);
--        dbms_output.put_line('inside innner' || v_inner);
            dbms_output.put_line('inside_inner -> ' || v_text);
            dbms_output.put_line('inside_outer -> ' || outer.v_text);
        END;

--    dbms_output.put_line('outside_inner' || v_inner);
--    dbms_output.put_line(v_outer);

        dbms_output.put_line('Outside -> ' || v_text);
    END;
END outer;
-- Outside the block variable will not execute ex: v_inner