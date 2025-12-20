D:\VS Code 03-05-2025\VS CODE\Pl-SQL\PL_SQL\ChaptersDECLARE
    TYPE t_edu IS RECORD (
        primary_school      VARCHAR2(100),
        high_school         VARCHAR2(100),
        university          VARCHAR2(100),
        uni_graduate_date   DATE
    );
    TYPE t_temp IS RECORD (
        first_name   VARCHAR2(50),
        last_name    employees.last_name%TYPE,
        salary       employees.salary%TYPE NOT NULL DEFAULT 10501,
        hire_date    date,
        dept_id      employees.department_id%TYPE,
        department   departments%rowtype,
        education    t_edu
    );
    r_emp t_temp;
BEGIN
    SELECT
        first_name,
        last_name,
        salary,
        hire_date,
        department_id
    INTO
        r_emp.first_name,
        r_emp.last_name,
        r_emp.salary,
        r_emp.hire_date,
        r_emp.dept_id
    FROM
        employees
    WHERE
        employee_id = '146';

    SELECT
        *
    INTO r_emp.department
    FROM
        departments
    WHERE
        department_id = r_emp.dept_id;

    r_emp.education.high_school := 'Bevery Hills';
    r_emp.education.uni_graduate_date := '01/01/2002';
    r_emp.education.university := 'OXFORD DICTIONARY';
    dbms_output.put_line(r_emp.first_name
                         || ' '
                         || r_emp.last_name
                         || ' earns '
                         || r_emp.salary
                         || ' and hired at : '
                         || r_emp.hire_date);

    dbms_output.put_line('She graduated from '
                         || r_emp.education.university
                         || ' at '
                         || r_emp.education.uni_graduate_date);

    dbms_output.put_line('Her Department Name is : ' || r_emp.department.department_name);
END;