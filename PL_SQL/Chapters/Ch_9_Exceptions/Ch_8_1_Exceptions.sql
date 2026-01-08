/*

    2 types of Error:
        1. Compile Time Error
        2. RunTime Error
    
    Handle Exception in 3 Ways:
        1.Trap  
            We have to catch it and take some actions.
        
        2. Propogate
            We directly propogate it to the calling subprogram or environment. We pass the handling job to some others.
        
        3. Trap and Propogate:
            I did some actions. But, you take your actions too.
        
    3 Types of Exception:
        1. Predefined Oracle Server Error.
        2. Non-Predefined Oracle Server Error.
        3. User-Defined Error.

*/

SET SERVEROUTPUT ON

DECLARE
    v_name VARCHAR2(6);
BEGIN
    SELECT first_name INTO v_name FROM employees WHERE employee_id = 50;
    dbms_output.put_line('Hello');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('There is no data avaiable in the table for this employee_id : 50');
END;