/*

    Oracle has 2 types of sql : 1. STATIC SQL       2. DYNAMIC SQL
        1. Static SQL:
            A good part to using it for if the statement is incorrect or any issues we will see before executing the script.
        
        2. Dynamic SQL:
            If we need to generate some queries at runtime on that time we use the dynamic sql. Dynamic SQL is a sql statement constructed as strings
            and executed dynamically at runtime.
    
    SQL Execution Stages : 4 Stages.
        1. PARSE    : Checking the SYNTAX, checking the old objects are correct and so on.
        2. BIND     : If the query contains bind variable means only come to this stage.
        3. EXECUTE  : In this stage only queries are executing.
        4. FETCH    : In this stage it retrives the data from the executed query.
    
    Why do we need DYNAMIC SQL?
        1. We may not know the full-text statement to be executed in advance.
        2. We may want to execute DDL Statement or SQL statement that are not supported in static sql statement.
        3. We may need dynamic plsql block that will work differenct in different situation.
    
    CONS:
        Dynamic sql leads to some problem such as error, privillage problem, SQL injection etc.
        Static SQL should be preferred over the dynamic sql, when possible. It is slower and harder to maintain.

    How to generate Dynamic SQL?
        1. NATIVE DYNAMIC SQL
        2. DBMS_SQL PACKAGE.
        
    
*/