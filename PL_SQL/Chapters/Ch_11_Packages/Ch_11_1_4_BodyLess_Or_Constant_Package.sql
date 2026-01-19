CREATE OR REPLACE PACKAGE constant_pkg AS
    v_salary_increase NUMBER := 0.04;
    CURSOR cur_emps IS
    SELECT * FROM employees;

    t_emps_type employees%rowtype;
    v_company_name VARCHAR2(20) := 'ORACLE';
END constant_pkg;
/