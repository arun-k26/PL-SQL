BEGIN
    EXECUTE IMMEDIATE 'grant select on employees to sys';
END;
/

GRANT
    CREATE TABLE
TO hr;
/

CREATE OR REPLACE PROCEDURE prc_create_table_dynamic (
    p_table_name   IN   VARCHAR2,
    p_col_specs    IN   VARCHAR2
) IS
BEGIN
    EXECUTE IMMEDIATE 'create table '
                      || p_table_name
                      || ' ('
                      || p_col_specs
                      || ')';
END;
/

EXECUTE prc_create_table_dynamic('dynamic_temp_table', 'id number primary key, name varchar2(100)');
/

SELECT * FROM dynamic_temp_table;
/

CREATE OR REPLACE PROCEDURE prc_generic (
    p_dynamic_sql IN VARCHAR2
) IS
BEGIN
    EXECUTE IMMEDIATE p_dynamic_sql;
END;
/


execute prc_generic ('drop table dynamic_temp_table');
/