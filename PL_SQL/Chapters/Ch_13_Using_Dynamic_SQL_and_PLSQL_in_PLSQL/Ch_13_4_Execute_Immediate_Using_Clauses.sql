/*

    Using clause is to assign bind variables in the dynamic statement.
    
    You can create the same query using the variables and concatenation with the previous method but since it will be passed on each time and
    this method won't
    
    Using bind variables  will increase the performance of the query.

*/
CREATE TABLE names (
    id     NUMBER PRIMARY KEY,
    name   VARCHAR2(100)
);
/

CREATE OR REPLACE FUNCTION insert_values (
    id     IN   NUMBER,
    name   IN   VARCHAR2
) RETURN PLS_INTEGER IS
BEGIN
    EXECUTE IMMEDIATE 'insert into names values(:a, :b)'
        USING id, name;
    RETURN SQL%rowcount;
END;
/

SET SERVEROUTPUT ON

DECLARE
    v_afftected_rows NUMBER;
BEGIN
    v_afftected_rows := insert_values(2, 'John');
    dbms_output.put_line(v_afftected_rows || 'rows inserted');
END;
/

SELECT
    *
FROM
    names;
/

ALTER TABLE names ADD (
    last_name VARCHAR2(100)
);

------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_names (
    id          IN   NUMBER,
    last_name   IN   VARCHAR2
--    first_name   OUT   VARCHAR2
) RETURN PLS_INTEGER IS
    v_dynamic_sql VARCHAR2(200);
BEGIN
    v_dynamic_sql := 'update names set last_name = :1 where id = :2';
    EXECUTE IMMEDIATE v_dynamic_sql
        USING last_name, id;
    RETURN SQL%rowcount;
END;
/

SET SERVEROUTPUT ON

DECLARE
    v_afftected_rows PLS_INTEGER;
BEGIN
    v_afftected_rows := update_names(2, 'Brown');
    dbms_output.put_line(v_afftected_rows || 'rows updated');
END;
/

-------------------------------------------------------------------------

/*
    Using COLUMN RETURNING INTO clause to store the column value that can be use in the update script. 
    RETURNING INTO CLAUSE is used to get back the affected DML values immediately store in the variable or collection or etc.
*/

CREATE OR REPLACE FUNCTION update_names (
    id           IN    VARCHAR2,
    last_name    IN    VARCHAR2,
    first_name   OUT   VARCHAR2
) RETURN PLS_INTEGER IS
    v_dynamic_sql VARCHAR2(200);
BEGIN
    v_dynamic_sql := 'update names set last_name = :1 where id = :2 returning name into :3';
    EXECUTE IMMEDIATE v_dynamic_sql
        USING IN last_name, id
    RETURNING
    INTO first_name;
    RETURN SQL%rowcount;
END;
/

SET SERVEROUTPUT ON

DECLARE
    v_afftected_rows   PLS_INTEGER;
    v_first_name       VARCHAR2(100);
BEGIN
    v_afftected_rows := update_names(2, 'KING', v_first_name);
    dbms_output.put_line(v_afftected_rows || 'rows updated');
    dbms_output.put_line(v_first_name);
END;
/