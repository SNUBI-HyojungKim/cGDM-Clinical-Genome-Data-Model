# **cGDM-Clinical-Genome-Data-Model**

The clinical Genome Data Model (cGDM) encompasses reliability-related factors that enable clinicians to access the reliability problem of each genomic test result as clinical evidence. 
The proposed cGDM could serve as a data-layer infrastructure supporting the intellectual interplay between medical experts and informed decision-making. 

## Contents

- Database Data Definition Language
	- [MySQL](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/MySQL)
    - [Oracle](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Oracle)
	- [PostgreSQL](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/PostgreSQL)
	- [SQL server(MSSQL)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/MSSQL)
    
    
- [Demo Database (with DDL for MySQL)](Demo Database)
	- [TCGA Pancreatic Adenocarcinoma(PAAD)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database)
    - [1000 Genome Phase 3(CEU)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database)

- [Licence](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model#License)
- Supplementary Figure
	- [Figure S1. Entity-relationship diagram of the cGDM implemented in RDBMS](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/Supplementary%20Figure%20S1.%20Entity-relationship%20diagram%20of%20the%20cGDM%20implemented%20in%20RDBMS.pdf)
    - [Table S1. Table Specification of the CGDM](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/Supplementary%20Table%20S1.%20Table%20Specification%20of%20the%20CGDM.xlsx)

## Demo Database
Two public data were imported into a cGDM-based database. This demo database is provided as an SQL statement executed by MySQL.
The provided two demo databases were created based on the following two public data:
1. [TCGA Pancreatic Adenocarcinoma(PAAD)](https://portal.gdc.cancer.gov/projects/TCGA-PAAD)
2. [1000 Genome Phase 3](https://www.internationalgenome.org/category/phase-3/)
	- In 1KGP3, only the sample data corresponding to the population code "CEU" ("Utah Residents with Northern and Western European Ancestry") were used.
    - The volume of this data is so large that it cannot be shared with github but through our server. - see the [Demo_Database/1000 Genome Phase 3 dataset](http://cipher.snubi.org:8800/github/cGDM_1KGP3_test_Dump.sql)
    

## Authors

* Hyo Jung Kim
* Hyeong Joon Kim
* Yoomi Park
* Woo-Seung Lee
* Younggyun Lim
* Ju Han Kim


## License

This project is licensed under the Seoul National University Biomedical Informatics (SNUBI), Division of Biomedical Informatics, Seoul National University College of Medicine, Seoul, Republic of Korea - see the [LICENSE.md](LICENSE.md) file for details

