select *
  from all_source
 where lower(type) = 'function'
   and lower(name) = 'get_emp';

select *
  from dba_source
 where lower(type) = 'function'
   and lower(name) = 'get_emp';

-- It will not work only in ORCLPB DB

select *
  from dba_source;