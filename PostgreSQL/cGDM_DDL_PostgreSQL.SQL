
/*******************************************************************************************
DDL(Data definition language) script to create cGDM(Clinical Genome Data Model) version 1.0
********************************************************************************************
# Created: 26-Nov-2019
# Last revised: 16-DEC-2019
# Database: PostgreSQL, tested Model: PostgreSQL 9.5.10
# 
# Authors:  Hyo Jung Kim, Hyeong Joon Kim
# 
# Copyright 2019 SNUBI (Seoul National University Biomedical Informatics Lab) 
# 
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

-- Table CLINICAL_IDENTIFIER

CREATE TABLE CLINICAL_IDENTIFIER
(
  Subject_Identifier Integer NOT NULL,
  Patient_Number Varchar(20) NOT NULL,
  Institution_Identifier Char(20) NOT NULL,
  Order_Identifier Char(20) NOT NULL,
  Clinician_Identifier Char(20) NOT NULL,
  Submission_Date Datetime NOT NULL,
  CONSTRAINT PK_Subject_Identifier PRIMARY KEY (
  Subject_Identifier
  )
)
;

-- Table EXPERIMENT_RELATED_INFORMATION

CREATE TABLE EXPERIMENT_RELATED_INFORMATION
(
  Experiment_Identifier Integer NOT NULL,
  Subject_Identifier Integer NOT NULL,
  Test_Description Text,
  Sequencing_Type Varchar(50) NOT NULL,
  Platform_Technology Varchar(20) NOT NULL,
  Sequencer Varchar(50) NOT NULL,
  Sequencing_Institution Varchar(50) NOT NULL,
  Experimenter Varchar(50) NOT NULL,
  Collection_Date Datetime NOT NULL,
  CONSTRAINT PK_EXPERIMENT_RELATED_INFORMATION PRIMARY KEY (
  Experiment_Identifier
  )
)
;

-- Table BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION

CREATE TABLE BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION
(
  BI_Protocol_Identifier Integer NOT NULL,
  Experiment_Identifier Integer NOT NULL,
  Pipeline_Name Varchar(50) NOT NULL,
  Step Int(3) NOT NULL,
  Tool Varchar(50) NOT NULL,
  Parameter Varchar(50) NOT NULL,
  Datasource_Origin Varchar(50) NOT NULL,
  Datasource_Version Varchar(50),
  Datasource_Build Varchar(50),
  Analytics_Institution Varchar(50) NOT NULL,
  Bioinformatician Varchar(50) NOT NULL,
  Received_Date Datetime NOT NULL,
  Documentation_Date Datetime NOT NULL,
  CONSTRAINT PK_BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION PRIMARY KEY (
  BI_Protocol_Identifier
  )
)
;

-- Table QUALITY_CHECK

CREATE TABLE QUALITY_CHECK
(
  QC_Identifier Integer NOT NULL,
  BI_Protocol_Identifier Integer NOT NULL,
  Total_Reads Bigint NOT NULL,
  Total_Aligned_Reads Bigint,
  Reads_Aligned_Percent Float,
  Total_Bases Bigint,
  Mapped_Bases Bigint,
  Depth_Mean Float,
  Depth_SD Float,
  Target_Bases Bigint,
  CONSTRAINT PK_QUALITY_CHECK PRIMARY KEY (
  QC_Identifier
  )
)
;

-- Table GENOMIC_ALTERATION

CREATE TABLE GENOMIC_ALTERATION
(
  Genomic_Alteration_Identifier Integer NOT NULL,
  BI_Protocol_Identifier Integer NOT NULL,
  Position Varchar(255) NOT NULL,
  Reference_Allele Varchar(255) NOT NULL,
  Alternative_Allele Varchar(255) NOT NULL,
  Chromosome Varchar(2) NOT NULL,
  Cytogenetic_Location Text,
  Codon Text,
  Exon Varchar(10),
  HGVS_Genomic_Change Text NOT NULL,
  HGVS_Coding_Change Text,
  HGVS_Protein_Change Text,
  HGVS_Version Varchar(20) NOT NULL,
  dbSNP_ID Varchar(20),
  dbVar_ID Varchar(20),
  Genome_Build Varchar(20),
  Genomic_Source Varchar(10) NOT NULL,
  HGNC_Gene_Symbol varchar(20),
  Entrez_ID Int,
  Ensembl_ID Char(15),
  Genotype Char(3),
  clinVar_Variant_ID Varchar(20),
  COSMIC_ID Varchar(10),
  Molecular_Effect Varchar(50),
  Variant_Type Varchar(20) NOT NULL,
  Functional_Domain Varchar(50),
  CONSTRAINT PK_GENOMIC_ALTERATION PRIMARY KEY (
  Genomic_Alteration_Identifier
  )
)
;

-- Table CLINICAL_ANNOTATION

CREATE TABLE CLINICAL_ANNOTATION
(
  Clinical_Annotation_Identifier Integer NOT NULL,
  Genomic_Alteration_Identifier Integer NOT NULL,
  Biomarker_Datasource Varchar(255) NOT NULL,
  Biomarker_Name Varchar(50) NOT NULL,
  CONSTRAINT PK_CLINICAL_ANNOTATION PRIMARY KEY (
  Clinical_Annotation_Identifier
  )
)
;

-- Table MICROSATELLITE_INSTABILITY

CREATE TABLE MICROSATELLITE_INSTABILITY
(
  MSI_Identifier Integer NOT NULL,
  BI_Protocol_Identifier Integer NOT NULL,
  Biomarker_Name Varchar(50) NOT NULL,
  MSI_Phenotype Varchar(50) NOT NULL,
  MSI_Marker_Name Varchar(20) NOT NULL,
  MSI_Marker_Status Varchar(20) NOT NULL,
  CONSTRAINT PK_MICROSATELLITE_INSTABILITY PRIMARY KEY (
  MICROSATELLITE_INSTABILITY
  )
)
;
