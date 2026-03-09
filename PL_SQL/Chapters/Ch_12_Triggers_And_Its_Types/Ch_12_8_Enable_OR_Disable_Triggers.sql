ALTER TRIGGER vw_emp_details ENABLE;

ALTER TRIGGER vw_emp_details DISABLE;

ALTER TABLE employees_copy ENABLE ALL TRIGGERS;

ALTER TABLE employees_copy DISABLE ALL TRIGGERS;


-- Compile the trigger manually
ALTER TRIGGER vw_emp_details COMPILE;