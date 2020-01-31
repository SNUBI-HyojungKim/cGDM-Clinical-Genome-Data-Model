# **cGDM-Clinical-Genome-Data-Model**

The clinical Genome Data Model (cGDM) encompasses reliability-related factors that enable clinicians to access the reliability problem of each genomic test result as clinical evidence. 
The proposed cGDM could serve as a data-layer infrastructure supporting the intellectual interplay between medical experts and informed decision-making. 

To get more information, and to access the cGDM as logical data model, please check our publication.
- Links to main article: 

	[Clinical Genome Data Model provides Interactive Clinical Decision Support for Precision Medicine](https://www.nature.com/articles/s41598-020-58088-2)

- Citation information

	Kim, H.J., Kim, H.J., Park, Y. et al. Clinical Genome Data Model (cGDM) provides Interactive Clinical Decision Support for
	Precision Medicine. Sci Rep 10, 1414 (2020). https://doi.org/10.1038/s41598-020-58088-2

## Graphical map of the contents outline
![그림1](https://user-images.githubusercontent.com/58065456/71191769-6c10cd00-22ca-11ea-89d9-128b2b2fd259.png)

## Contents

- Database Data Definition Language
	- [MySQL](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/MySQL)
    - [Oracle](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Oracle)
	- [PostgreSQL](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/PostgreSQL)
	- [SQL server(MSSQL)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/MSSQL)
    
    
- [Demo Database (with DDL for MySQL)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model#Demo_Database)
	- [TCGA Pancreatic Adenocarcinoma(PAAD)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database)
    - [1000 Genome Phase 3(CEU)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database)

- [IWPC algorithm implementation for logical validation](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/IWPC_warfarin_dosing_implemented_on_the_cGDM)

- [Licence](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model#License)
- Supplementary Figure
	- [Figure S1. Entity-relationship diagram of the cGDM implemented in RDBMS](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/Supplementary%20Figure%20S1.%20Entity-relationship%20diagram%20of%20the%20CGDM%20implemented%20in%20RDBMS.pdf)
    - [Table S1. Table Specification of the cGDM](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/Supplementary%20Table%20S1.%20Table%20Specification%20of%20the%20CGDM.xlsx)

## Demo_Database
Two public data were imported into a cGDM-based database. This demo database is provided as an SQL statement executed by MySQL.
The provided two demo databases were created based on the following two public data:
1. [TCGA Pancreatic Adenocarcinoma(PAAD)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database) [- link](https://portal.gdc.cancer.gov/projects/TCGA-PAAD)
2. [1000 Genome Phase 3 (CEU)](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database) [- link](https://www.internationalgenome.org/category/phase-3/)
	- In 1KGP3, only the sample data corresponding to the population code "CEU" ("Utah Residents with Northern and Western European Ancestry") were used.
    - The volume of this data is so large that it cannot be shared with github but through our server. - see the [Demo_Database/1000 Genome Phase 3 dataset](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/Demo_Database)

## IWPC algorithm implementation for logical validation
We provide a PGX CDS algorithm deveploped on cGDM to illustrate how implementation of the CGDM provides interactive clinical decision support when it linked in clinical information system. For detail architectual understanding, please check original manuscript and supplementary figure S3 as well. As below, the result value-set of this function, coded in terms of SQL stored procedure, is shown. 

![image](https://user-images.githubusercontent.com/58065456/73509879-fbf67a80-4423-11ea-8877-32ab815ac1e7.png)
[-link](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/tree/master/IWPC_warfarin_dosing_implemented_on_the_cGDM)

## Authors

* Hyo Jung Kim
* Hyeong Joon Kim
* Yoomi Park
* Woo-Seung Lee
* Younggyun Lim
* Ju Han Kim


## License

This project is licensed under the Seoul National University Biomedical Informatics (SNUBI), Division of Biomedical Informatics, Seoul National University College of Medicine, Seoul, Republic of Korea - see the [LICENSE.md](https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/blob/master/README.md) file for details

