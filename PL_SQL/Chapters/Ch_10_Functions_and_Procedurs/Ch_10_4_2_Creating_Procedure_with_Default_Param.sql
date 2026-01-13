CREATE OR REPLACE PROCEDURE add_job (
    job_id       VARCHAR2,
    job_title    VARCHAR2,
    min_salary   NUMBER DEFAULT 1000,
    max_salary   NUMBER DEFAULT NULL
) AS
BEGIN
    INSERT INTO jobs VALUES (
        job_id,
        job_title,
        min_salary,
        max_salary
    );

    print('The job : '
          || job_title
          || ' is inserted !!...');
END;
/