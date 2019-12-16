USE `cGDM_1KGP3_Test`;

DROP PROCEDURE IF EXISTS `Get_Wafarin_Pharmacogenomic_Dosing_Result`;

DELIMITER $$

CREATE PROCEDURE `Get_Wafarin_Pharmacogenomic_Dosing_Result` 
(IN  Age_in_Year SMALLINT, Height_in_cm smallint, Weight_in_kg smallint , Patient_Number varchar(20), Race CHAR(1), Taking_Enzyme_Inducer cHAR(1), Taking_Amiodarone CHAR(1) )
BEGIN

/***************************************************************************************************************
PGx CDS example script: seamless IWCP warfarin dose calulation along with the cGDM | version 1.0
****************************************************************************************************************
# Created: 10-DEC-2019
# Last revised: 16-DEC-2019
# Database: MySQL, tested Model: MySQL 5.6
#
# Logical reference: Consortium, I. W. P. Estimation of the warfarin dose with clinical and pharmacogenetic data. 
# New England Journal of Medicine 360, 753-764 (2009).
# 
# Authors:  Hyo Jung Kim
#
# Execute example: 
# CALL Get_Wafarin_Pharmacogenomic_Dosing_Result ( 22, 175, NULL, 'NA12400', 'U','N','N'); -- Invalid input 
# CALL Get_Wafarin_Pharmacogenomic_Dosing_Result ( 22, 175, 70, 'NA12400', 'U','N','N'); -- Valid case 
#
# Copyright of the SQL script 2019 SNUBI (Seoul National University Biomedical Informatics Lab) 
# Licensed under the GENERAL PUBLIC LICENSE, Version 3, 29 June 2007;
# You may obtain a copy of the License at
# https://www.gnu.org/licenses/gpl-3.0.html 
# 
# Every related matarial about the cGDM is freely available on GitHub site
  : https://github.com/SNUBI-HyojungKim/cGDM-Clinical-Genome-Data-Model/
  
  including 
  - Logical data model (Entity-Attribute model)
  - Physical database implementation sources
	- ERD(Entity relationship diagram)
	- DDL script (for MySQL, MSSQL, Oracle, PostgreSQL)
	- demo database 
******************************************************************************************/
DECLARE RESULT VARCHAR(255);

########### Declare functional input variables 
SET @Age_in_decades = truncate(Age_in_Year/10,0);

## initiation of the varables 
SET @VKORC1_Genotype = 'Unknown' , @CYP2C9_Genotype = 'Unknown';

SET @BI_Protocol_Identifier = (SELECT BPI.BI_Protocol_Identifier FROM CLINICAL_IDENTIFIER CI
	JOIN EXPERIMENT_RELATED_INFORMATION ERI ON CI.Subject_Identifier = ERI.Subject_Identifier
    JOIN BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION BPI ON BPI.Experiment_Identifier = ERI.Experiment_Identifier
    WHERE CI.Patient_Number = Patient_Number) ;

## Create Rule criteria
DROP temporary TABLE  IF EXISTS `Wafarin_Related_Variant_Data`;
CREATE temporary TABLE Wafarin_Related_Variant_Data
( Genomic_Alteration_Identifier int not null
, BI_Protocol_Identifier int
, HGNC_Gene_Symbol varchar(20) 
, dbSNP_ID varchar(20) 
, Position VARCHAR(255)
, Reference_Allele varchar(255) 
, Alternative_Allele varchar(255) 
, Genotype varchar(10)
, Star_allele varchar(10)
, Star_allele_Diplotype VARCHAR(10)
) engine = memory;

INSERT INTO Wafarin_Related_Variant_Data
SELECT GA.Genomic_Alteration_Identifier, GA.BI_Protocol_Identifier, GA.HGNC_Gene_Symbol, GA.dbSNP_ID, GA.position, GA.Reference_Allele, GA.Alternative_Allele, GA.Genotype , '' AS star_allele, NULL 
FROM GENOMIC_ALTERATION GA WHERE HGNC_Gene_Symbol = 'VKORC1' AND dbSNP_ID in ('rs9923231') AND Reference_Allele = 'G' AND Alternative_Allele = 'A' AND BI_Protocol_Identifier = @BI_Protocol_Identifier
UNION
SELECT GA.Genomic_Alteration_Identifier, BI_Protocol_Identifier, GA.HGNC_Gene_Symbol, GA.dbSNP_ID, GA.position, GA.Reference_Allele, GA.Alternative_Allele, GA.Genotype , '*1' AS star_allele, NULL
FROM GENOMIC_ALTERATION GA WHERE HGNC_Gene_Symbol = 'CYP2C9' AND dbSNP_ID in ('rs9332094') AND Reference_Allele = 'T' AND Alternative_Allele = 'T' AND BI_Protocol_Identifier = @BI_Protocol_Identifier
UNION
SELECT GA.Genomic_Alteration_Identifier, BI_Protocol_Identifier, GA.HGNC_Gene_Symbol, GA.dbSNP_ID, GA.position, GA.Reference_Allele, GA.Alternative_Allele, GA.Genotype , '*2' AS star_allele, NULL
FROM GENOMIC_ALTERATION GA WHERE HGNC_Gene_Symbol = 'CYP2C9' AND dbSNP_ID in ('rs1799853') AND Reference_Allele = 'C' AND Alternative_Allele = 'T' AND BI_Protocol_Identifier = @BI_Protocol_Identifier 
UNION
SELECT GA.Genomic_Alteration_Identifier, BI_Protocol_Identifier, GA.HGNC_Gene_Symbol, GA.dbSNP_ID, GA.position, GA.Reference_Allele, GA.Alternative_Allele, GA.Genotype , '*3' AS star_allele, NULL
FROM GENOMIC_ALTERATION GA WHERE HGNC_Gene_Symbol = 'CYP2C9' AND dbSNP_ID in ('rs1057910') AND Reference_Allele = 'A' AND Alternative_Allele = 'C' AND BI_Protocol_Identifier = @BI_Protocol_Identifier; 

## @VKORC1_Genotype identification query from cGDM
SET @VKORC1_Genotype = (SELECT IFNULL((SELECT CASE WHEN Genotype = '0|0' THEN 'G/G' ELSE CONCAT(Reference_Allele,'/',Alternative_Allele) END
FROM Wafarin_Related_Variant_Data WHERE HGNC_Gene_Symbol = 'VKORC1'),'Unknown'));

SELECT BI_Protocol_Identifier 
, CONCAT(MAX(CASE WHEN LEFT(Genotype,1) = 1 THEN Star_allele ELSE '*1' END) 
,'/', MAX(CASE WHEN RIGHT(Genotype,1) = 1 THEN Star_allele ELSE '*1' END) ) AS Star_Allele_Genotype
 FROM Wafarin_Related_Variant_Data WHERE HGNC_Gene_Symbol = 'CYP2C9'
GROUP BY BI_Protocol_Identifier;

## @CYP2C9_Genotype identification query from cGDM
SET @CYP2C9_Genotype =  (SELECT CONCAT(MAX(CASE WHEN LEFT(Genotype,1) = 1 THEN Star_allele ELSE '*1' END) 
,'/', MAX(CASE WHEN RIGHT(Genotype,1) = 1 THEN Star_allele ELSE '*1' END) ) 
FROM Wafarin_Related_Variant_Data WHERE BI_Protocol_Identifier = @BI_Protocol_Identifier GROUP BY BI_Protocol_Identifier);

DROP TABLE  IF EXISTS `IWPC_coefficient_given_genotype_table`;
CREATE TABLE IWPC_coefficient_given_genotype_table
(  HGNC_Gene_Symbol varchar(20) 
, Final_Genotype varchar(20) -- could be reference/alternative allele, or star allele name in forms of diploid
, coefficient real
) engine = memory;

INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('VKORC1','G/G',0);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('VKORC1','A/G',0.8677);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('VKORC1','A/A',1.6974);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('VKORC1','Unknown',0.4854);

INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','*1/*1',0);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','*1/*2',0.5211);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','*1/*3',0.9357);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','*2/*2',1.0616);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','*2/*3',1.9206);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','*3/*3',2.3312);
INSERT INTO IWPC_coefficient_given_genotype_table VALUES ('CYP2C9','Unknown',0.2188);

## Pharmacogenetic dosing calculating
SET @Sqrt_Dose = (SELECT 5.6044 - 0.2614 * @Age_in_decades + 0.0087 * Height_in_cm + 0.0128 * Weight_in_kg
- (SELECT coefficient FROM IWPC_coefficient_given_genotype_table WHERE HGNC_Gene_Symbol = 'VKORC1' AND Final_Genotype = @VKORC1_Genotype) 
- (SELECT coefficient FROM IWPC_coefficient_given_genotype_table WHERE HGNC_Gene_Symbol = 'CYP2C9' AND Final_Genotype = @CYP2C9_Genotype)
- (SELECT IF(Race = 'A',0.1092, IF(Race = 'B', 0.2760, IF(Race = 'M',0.1032, 0))))
+ (SELECT IF(Taking_Enzyme_Inducer = 'Y', 1.1816,0))
- (SELECT IF(Taking_Amiodarone = 'Y',0.5503,0))) ;

DROP TABLE Wafarin_Related_Variant_Data;
DROP TABLE IWPC_coefficient_given_genotype_table; 

########### Check Input Value Validity
## Variable check examples; you can make validity check statement both in the SQL level and front-end UI.

IF ( Age_in_Year * Height_in_cm * Weight_in_kg IS NULL OR Race NOT IN ('A','B','M','U') OR Taking_Enzyme_Inducer NOT IN ('Y','N') OR Taking_Amiodarone NOT IN ('Y','N') )
THEN 
SELECT 'ERROR: Invalid value encountered for the input variables. 
\n check your selected database or input values' AS ERROR_MESSAGE;
ELSE 
SELECT ROUND(POW(@Sqrt_Dose,2),0)AS Weekly_Warfarin_Dose_in_mg, @VKORC1_Genotype AS VKORC1_Genotype, @CYP2C9_Genotype AS CYP2C9_Genotype;
END IF;
    
END $$
DELIMITER ; 
