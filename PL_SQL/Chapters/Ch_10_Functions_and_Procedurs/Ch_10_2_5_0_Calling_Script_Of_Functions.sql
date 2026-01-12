--Ex : 10_2_5_1
SET SERVEROUTPUT ON

BEGIN
    dbms_output.put_line(get_avg_sal(50));
END;
/

--Ex : 10_2_5_1.1

SET SERVEROUTPUT ON

DECLARE
    v_avg_salary NUMBER;
BEGIN
    v_avg_salary := get_avg_sal(50);
    dbms_output.put_line(v_avg_salary);
END;
/

--Ex : 10_2_5_1.2

SELECT
    get_avg_sal(department_id) avg_sal
FROM
    employees
WHERE
    salary > get_avg_sal(department_id)
GROUP BY
    get_avg_sal(department_id)
ORDER BY
    get_avg_sal(department_id);