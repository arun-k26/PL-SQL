VARIABLE var_sql NUMBER;

BEGIN
    :var_sql := 100;
END;

SELECT
    *
FROM
    employees
WHERE
    employee_id = :var_sql;
