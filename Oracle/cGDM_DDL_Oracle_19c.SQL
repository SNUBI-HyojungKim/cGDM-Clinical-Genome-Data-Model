
/*******************************************************************************************
DDL(Data definition language) script to create cGDM(Clinical Genome Data Model) version 1.0
********************************************************************************************
# Created: 26-Nov-2019
# Last revised: 26-Nov-2019
# Database: Oracle, tested Model: Oracle 19c
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

-- Create sequences section -------------------------------------------------

CREATE SEQUENCE "Seq_CLINICAL IDENTIFIER_Subject Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_EXPERIMENT RELATED INFORMATION_Experiment_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_BIOINFORMATICS PROTOCOL RELATED INFORMATION_BI_Protocol_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_QUALITY CHECK_QC_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_GENOMIC ALTERATION_Genomic_Alteration_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_CLINICAL ANNOTATION_Clinical_Annotation_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_MICROSATELLITE INSTABILITY_MSI_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_TUMOR MUTATION BURDEN_TMB_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

-- Create tables section -------------------------------------------------

-- Table CLINICAL IDENTIFIER

CREATE TABLE "CLINICAL IDENTIFIER"(
  "Subject Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Patient Number" Varchar2(20 ) NOT NULL,
  "Institution Identifier" Char(20 ) NOT NULL,
  "Order_Identifier" Char(20 ) NOT NULL,
  "Clinician_Identifier" Char(20 ) NOT NULL,
  "Submission_Date" Date NOT NULL
)
/

-- Add keys for table CLINICAL IDENTIFIER

ALTER TABLE "CLINICAL IDENTIFIER" ADD CONSTRAINT "PK_CLINICAL IDENTIFIER" PRIMARY KEY ("Subject Identifier")
/

-- Table EXPERIMENT RELATED INFORMATION

CREATE TABLE "EXPERIMENT RELATED INFORMATION"(
  "Experiment_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Subject_Identifier" Integer NOT NULL,
  "Order_Identifier" Varchar2(20 ) NOT NULL,
  "Test_Description" Clob,
  "Sequencing_Type" Varchar2(50 ) NOT NULL,
  "Platform_Technology" Varchar2(20 ) NOT NULL,
  "Sequencer" Varchar2(50 ) NOT NULL,
  "Sequencing_Institution" Varchar2(50 ) NOT NULL,
  "Experimenter" Varchar2(50 ) NOT NULL,
  "Collection_Date" Date NOT NULL
)
/

-- Add keys for table EXPERIMENT RELATED INFORMATION

ALTER TABLE "EXPERIMENT RELATED INFORMATION" ADD CONSTRAINT "PK_EXPERIMENT RELATED INFORMATION" PRIMARY KEY ("Experiment_Identifier")
/

-- Table BIOINFORMATICS PROTOCOL RELATED INFORMATION

CREATE TABLE "BIOINFORMATICS PROTOCOL RELATED INFORMATION"(
  "BI_Protocol_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Experiment_Identifier" Integer NOT NULL,
  "Pipeline_Name" Varchar2(50 ) NOT NULL,
  "Step" Integer NOT NULL,
  "Tool" Varchar2(50 ) NOT NULL,
  "Parameter" Varchar2(50 ) NOT NULL,
  "Datasource_Origin" Varchar2(50 ) NOT NULL,
  "Datasource_Version" Varchar2(50 ),
  "Datasource_Build" Varchar2(50 ),
  "Analytics_Institution" Varchar2(50 ) NOT NULL,
  "Bioinformatician" Varchar2(50 ) NOT NULL,
  "Received_Date" Date NOT NULL,
  "Documentation_Date" Date NOT NULL
)
/

-- Add keys for table BIOINFORMATICS PROTOCOL RELATED INFORMATION

ALTER TABLE "BIOINFORMATICS PROTOCOL RELATED INFORMATION" ADD CONSTRAINT "PK_BIOINFORMATICS PROTOCOL RELATED INFORMATION" PRIMARY KEY ("BI_Protocol_Identifier")
/

-- Table QUALITY CHECK

CREATE TABLE "QUALITY CHECK"(
  "QC_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "BI_Protocol_Identifier" Integer NOT NULL,
  "Total_Reads" Integer NOT NULL,
  "Total_Aligned_Reads" Integer,
  "Reads_Aligned_Percent" Real,
  "Total_Bases" Integer,
  "Mapped_Bases" Integer,
  "Depth_Mean" Real,
  "Depth_SD" Real,
  "Target_Bases" Integer
)
/

-- Add keys for table QUALITY CHECK

ALTER TABLE "QUALITY CHECK" ADD CONSTRAINT "PK_QUALITY CHECK" PRIMARY KEY ("QC_Identifier")
/

-- Table GENOMIC ALTERATION

CREATE TABLE "GENOMIC ALTERATION"(
  "Genomic_Alteration_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "BI_Protocol_Identifier" Integer NOT NULL,
  "Position" Varchar2(255 ) NOT NULL,
  "Reference_Allele" Varchar2(255 ) NOT NULL,
  "Alternative_Allele" Varchar2(255 ) NOT NULL,
  "Chromosome" Varchar2(2 ) NOT NULL,
  "Cytogenetic_Location" Clob,
  "Codon" Clob NOT NULL,
  "Exon" Varchar2(10 ),
  "HGVS_Genomic_Change" Clob NOT NULL,
  "HGVS_Coding_Change" Clob,
  "HGVS_Protein_Change" Clob,
  "HGVS_Version" Varchar2(20 ) NOT NULL,
  "dbSNP_ID" Varchar2(20 ),
  "dbVar_ID" Varchar2(20 ),
  "Genome_Build" Varchar2(20 ),
  "Genomic_Source" Varchar2(10 ) NOT NULL,
  "HGNC_ID" Varchar2(10 ),
  "Entrez_ID" Integer,
  "Ensembl_ID" Char(15 ),
  "Genotype" Char(3 ),
  "clinVar_Variant_ID" Varchar2(20 ),
  "COSMIC_ID" Varchar2(10 ),
  "Molecular_Effect" Varchar2(20 ),
  "Variant_Type" Varchar2(20 ) NOT NULL,
  "Functional_Domain" Varchar2(50 )
)
/

-- Add keys for table GENOMIC ALTERATION

ALTER TABLE "GENOMIC ALTERATION" ADD CONSTRAINT "PK_GENOMIC ALTERATION" PRIMARY KEY ("Genomic_Alteration_Identifier")
/

-- Table CLINICAL ANNOTATION

CREATE TABLE "CLINICAL ANNOTATION"(
  "Clinical_Annotation_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Genomic_Alteration_Identifier" Integer NOT NULL,
  "Biomarker_Datasource" Varchar2(255 ) NOT NULL,
  "Biomarker_Name" Varchar2(50 ) NOT NULL
)
/

-- Add keys for table CLINICAL ANNOTATION

ALTER TABLE "CLINICAL ANNOTATION" ADD CONSTRAINT "PK_CLINICAL ANNOTATION" PRIMARY KEY ("Clinical_Annotation_Identifier")
/

-- Table MICROSATELLITE INSTABILITY

CREATE TABLE "MICROSATELLITE INSTABILITY"(
  "MSI_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "BI_Protocol_Identifier" Integer NOT NULL,
  "Biomarker_Name" Varchar2(50 ) NOT NULL,
  "MSI_Phenotype" Varchar2(50 ) NOT NULL,
  "MSI_Marker_Name" Varchar2(20 ) NOT NULL,
  "MSI_Marker_Status" Varchar2(20 ) NOT NULL
)
/

-- Add keys for table MICROSATELLITE INSTABILITY

ALTER TABLE "MICROSATELLITE INSTABILITY" ADD CONSTRAINT "PK_MICROSATELLITE INSTABILITY" PRIMARY KEY ("MSI_Identifier")
/

-- Table TUMOR MUTATION BURDEN

CREATE TABLE "TUMOR MUTATION BURDEN"(
  "TMB_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "BI_Protocol_Identifier" Integer NOT NULL,
  "Biomarker_Name" Varchar2(50 ) NOT NULL,
  "Burden_Call" Varchar2(20 ) NOT NULL,
  "Burden_Score" Real NOT NULL,
  "Burden_Unit" Varchar2(20 ) NOT NULL
)
/

-- Add keys for table TUMOR MUTATION BURDEN

ALTER TABLE "TUMOR MUTATION BURDEN" ADD CONSTRAINT "PK_TUMOR MUTATION BURDEN" PRIMARY KEY ("TMB_Identifier")
/






