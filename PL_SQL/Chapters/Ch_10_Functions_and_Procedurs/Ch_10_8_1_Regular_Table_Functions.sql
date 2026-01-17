create type t_days as object (
    v_date date,
    v_day_number int
);
/

create type t_days_tab is table of t_days;
/

CREATE OR REPLACE FUNCTION f_get_days (
    p_start_date   DATE,
    p_day_number   INT
) RETURN t_days_tab as
    v_days t_days_tab := t_days_tab();
BEGIN
    FOR i IN 1..p_day_number LOOP
        v_days.extend;
        v_days(i) := t_days(p_start_date + i, to_number(to_char(p_start_date + i, 'DDD')));

    END LOOP;

    RETURN v_days;
END;
/

select * from table(f_get_days(sysdate, 1000000));
select * from f_get_days(sysdate, 1000000);
/