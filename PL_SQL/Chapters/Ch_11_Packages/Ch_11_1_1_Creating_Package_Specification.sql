/*
    We are using the package is only one major reason is : PERFORMANCE. If mulitple user try to access the same object or procedure or function
    or anything it will load in PGA then execute it without you are not using PACKAGE. If you use the package means multiple users access the 
    same object then that memory is loaded into SGA(Shared Global Area). It will load memory only once in the memory then shared those memory
    for the multiple users to call the same object or procedure or function.
*/
create or replace package EMP as 
    v_salary_increase_rate number := 1000;
    cursor cur_emps is select * from employees;
    procedure increase_salaries;
    function get_avg_sal(p_dept_id int) return number;
end EMP;
