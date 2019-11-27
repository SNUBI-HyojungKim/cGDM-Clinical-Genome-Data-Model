# Clinical Genome Data Model v1.0 / Oracle

This folder contains the SQL scripts for Oracle.

How to excute:

1. Create an empty schema on your Oracle Server.
For example,
```SQL
create tablespace cGDM datafile [path/file name] ;
```

2. Execute the ddl script to create the tables and fields.

3. Load your data or demo dataset into the schema.

4. Instead of the step 1-3, the demo database source in forms of T-SQL is also avaliable 
at https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/
