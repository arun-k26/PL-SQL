--Ex : Notation
--1 Position Notation
exec add_job('CT_SCAN', 'IT Director', 5000, 20000);

--2 Mixed Notation
exec add_job('IT_DIR4', 'IIT Director', max_salary => 696969);
exec add_job(min_salary => 10, 'IT_DIR10', 'IIT Director', max_salary => 696969); -- We can't write the position notation after the named notation. It will throw an error
--fix
exec add_job('IT_DIR10', 'IIT Director', max_salary => 696969, min_salary => 10);

--3 Named Notation
exec add_job(job_title => 'IIT1 Director', job_id => 'IT_DIR11', max_salary => 696969, min_salary => 10);