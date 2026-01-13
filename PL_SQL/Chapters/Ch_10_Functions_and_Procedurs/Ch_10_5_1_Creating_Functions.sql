CREATE OR REPLACE FUNCTION get_avg_sal (
    p_dept_id departments.department_id%TYPE
) RETURN VARCHAR2 AS
    v_avg_sal NUMBER;
BEGIN
    SELECT
        AVG(salary)
    INTO v_avg_sal
    FROM
        employees
    WHERE
        department_id = p_dept_id;

    RETURN v_avg_sal;
END get_avg_sal;