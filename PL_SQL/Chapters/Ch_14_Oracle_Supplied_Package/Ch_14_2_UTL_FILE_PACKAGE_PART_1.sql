/*
    UTL_FILE Package is used to read and write to an any operating system files that are accessible to the database server.
    It provides file access on both the server and client side.
    The UTL_FILE Package operates on :
        The path specified in the UTL_FILE_DIR parameter.
            UTL_FILE_DIR = C:\My_files
            
    FOPEN Function : Opens a file to read, write or append.
    FOPEN (
        location in varchar2, 
        file_name in varchar2,
        open_mode in varchar2,                  -- Open mode : r - read , w - write , a - append , rb - read binary , wb - write binary, ab - append binary
        max_linesize in binary_integer default null 
    ) return file_type;
    
    file_type is a record private to the UTL_FILE package and also called as file handle.
    
    type file_type is record (
        id binary_integer,
        data_type binary_integer,
        byte_mode boolean
    );
    
    is_open funcation : Returns true if the file is in already open.
        IS_OPEN(file in file_type) return boolean;
    
    FCLOSE FUNCTION : Closes an opened file with the file handle.
        FCLOSE (file in out file_type);
*/