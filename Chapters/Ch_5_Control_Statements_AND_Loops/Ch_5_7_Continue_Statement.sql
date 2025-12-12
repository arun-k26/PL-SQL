DECLARE
 v_inner NUMBER := 1;
BEGIN
<<outer_loop>>
 FOR v_outer IN 1..10 LOOP
  dbms_output.put_line('My outer value is : ' || v_outer );
    v_inner := 1;
    <<inner_loop>>
    LOOP
      v_inner := v_inner + 1;
      CONTINUE outer_loop WHEN v_inner = 10;
      dbms_output.put_line('  My inner value is : ' || v_inner );
    END LOOP inner_loop;
 END LOOP outer_loop;
end;