/*
    If the query is written inside the single quotes then it is considered as DYNAMIC SQL.
*/
DECLARE
    TYPE emp_cur_type IS REF CURSOR;
    emp_cursor   emp_cur_type;
    emp_record   employees%rowtype;
BEGIN
    OPEN emp_cursor FOR 'select * from employees where job_id = ''IT_PROG''';

    FETCH emp_cursor INTO emp_record;
    dbms_output.put_line(emp_record.first_name || emp_record.last_name);
    CLOSE emp_cursor;
END;
/

-------------------------------------------------------------------------------

DECLARE
    TYPE emp_cur_type IS REF CURSOR;
    emp_cursor   emp_cur_type;
    emp_record   employees%rowtype;
BEGIN
    OPEN emp_cursor FOR 'select * from employees where job_id = :1'
        USING 'IT_PROG';

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%notfound;
        dbms_output.put_line(emp_record.first_name || emp_record.last_name);
    END LOOP;

    CLOSE emp_cursor;
END;

----------------------------------------------------------------------------------------

DECLARE
    TYPE emp_cur_type IS REF CURSOR;
    emp_cursor     emp_cur_type;
    emp_record     employees%rowtype;
    v_table_name   VARCHAR2(20);
BEGIN
    v_table_name := 'employees';
    OPEN emp_cursor FOR 'select * from '
                        || v_table_name
                        || ' where job_id = :1'
        USING 'IT_PROG';

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%notfound;
        dbms_output.put_line(emp_record.first_name || emp_record.last_name);
    END LOOP;

    CLOSE emp_cursor;
END;