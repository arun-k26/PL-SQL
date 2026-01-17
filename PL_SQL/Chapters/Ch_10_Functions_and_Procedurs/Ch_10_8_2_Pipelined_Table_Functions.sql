/*
    Normally SQL Developer return first 50 rows. But, the function completed the entire collection and then send it to us.
    We can see that by scroll down.
    However, sometimes it will be enough to get the first n values. Or sometimes, you may have some memory problems.
    To avoid the problems ->
        We use the PIPELINED TABLE FUNCTIONS.
            As i pointed before, Instead of completing whole collection, pipelined table functions return each row as soon it is prepared.
            Pipeline Table function is a bit different than the regular table functions.
            
            One important thing in pipelined table functions is we don't returned any nested table or something.
            We simple returned the object. So no need to initialize any nested table or something.
            So we simply pipe our rows to each other with using the pipe row operator. We simply type PIPE ROW and take our 
            object inside of paranthesis.
            
            By this way, the function will continue returning row until our loop finishes.
            
            Our function is now pushes each row without waiting to complete all the rows, there is no need to reutrn something.
            actually, it returned all the rows before it comes to the line of the return keyword.Do, we simple write return keyword alone.
*/
CREATE OR REPLACE FUNCTION f_get_days_piped (
    p_start_date   DATE,
    p_day_number   INT
) RETURN t_days_tab pipelined AS
--    v_days t_days_tab := t_days_tab();
BEGIN
    FOR i IN 1..p_day_number LOOP
--        v_days.extend;
--        v_days(i) := 
     PIPE ROW ( t_days(p_start_date + i, to_number(to_char(p_start_date + i, 'DDD'))) );
    END LOOP;

--    RETURN v_days;

    return;
END;
/

/*
    So if you execute now you can check the execution time. It tooks literally 0.275 seconds in pipelined table function.
    But in regular table functions it tooks more than 2 second to execute.
    So compared to regular table function, pipelined table function literally improves the speed of the execution.
    
    AND remember one thing regular and pipelined table functions is only used to reading purpose not writing purpose.
*/
select * from table((f_get_days_piped(sysdate, 1000000)));