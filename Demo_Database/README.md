# Demo Databases / MySQL 

This folder contains the SQL scripts for MySQL.

Each script contains database creation with demo dataset.


## How to create [1KGP3_CEU demo database](1KGP3_CEU): 

1. Download SQL file from URL : http://cipher.snubi.org:8800/github/cGDM_1KGP3_Test.sql

2. CREATE empty MySQL database :
```sql
CREATE Database cGDM;
```

2. Excute SQL script :
```sh
mysql -u[user] -p [cGDM] < cGDM_1KGP3_Test.sql
``` 
