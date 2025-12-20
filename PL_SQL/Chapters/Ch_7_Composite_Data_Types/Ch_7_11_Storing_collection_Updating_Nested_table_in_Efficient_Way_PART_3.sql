declare 
    p_num n_phone_no;
    
begin 
    select N_PH_NO into p_num from emp_with_phones_2 where emp_id = 103;
    p_num.extend;
    p_num(p_num.last) :=  t_phone_no('FAX','6969692525');
    update emp_with_phones_2 set f_name='ArUMUGAM', l_name = 'GOWTHAM', n_ph_no = p_num where emp_id = 103;
    
end;



