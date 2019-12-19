# Demo Databases / MySQL 

This folder contains the SQL scripts for MySQL.

Each script contains database creation with demo dataset.


## How to create Demo databases : 

1. Download SQL file :
- [1KGP3_CEU demo database](1KGP3_CEU) or URL http://cipher.snubi.org:8800/github/cGDM_1KGP3_Test.sql (92.69GB)
- [cGDM TCGA PAAD](cGDM_TCGA_PAAD_Demo_Database.sql) (9.41MB)

2. CREATE empty MySQL database :
```sql
CREATE Database cGDM;
```

3. Excute SQL script :
```sh
mysql -u[user] -p [cGDM] < cGDM_1KGP3_Test.sql
``` 
