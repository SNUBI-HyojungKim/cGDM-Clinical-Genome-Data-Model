
/*******************************************************************************************
DDL(Data definition language) script to create cGDM(Clinical Genome Data Model) version 1.0
********************************************************************************************
# Created: 26-Nov-2019
# Last revised: 16-DEC-2019
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

CREATE SEQUENCE "Seq_CLINICAL_IDENTIFIER_Subject_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_EXPERIMENT_RELATED_INFORMATION_Experiment_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION_BI_Protocol_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_QUALITY_CHECK_QC_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_GENOMIC_ALTERATION_Genomic_Alteration_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_CLINICAL_ANNOTATION_Clinical_Annotation_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE "Seq_MICROSATELLITE_INSTABILITY_MSI_Identifier"
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

-- Create tables section -------------------------------------------------

-- Table CLINICAL_IDENTIFIER

CREATE TABLE "CLINICAL_IDENTIFIER"(
  "Subject_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Patient_Number" Varchar2(20 ) NOT NULL,
  "Institution_Identifier" Char(20 ) NOT NULL,
  "Order_Identifier" Char(20 ) NOT NULL,
  "Clinician_Identifier" Char(20 ) NOT NULL,
  "Submission_Date" Date NOT NULL
)
/

-- Add keys for table CLINICAL_IDENTIFIER

ALTER TABLE "CLINICAL_IDENTIFIER" ADD CONSTRAINT "PK_CLINICAL_IDENTIFIER" PRIMARY KEY ("Subject_Identifier")
/

-- Table EXPERIMENT_RELATED_INFORMATION

CREATE TABLE "EXPERIMENT_RELATED_INFORMATION"(
  "Experiment_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Subject_Identifier" Integer NOT NULL,
  "Test_Description" Clob,
  "Sequencing_Type" Varchar2(50 ) NOT NULL,
  "Platform_Technology" Varchar2(20 ) NOT NULL,
  "Sequencer" Varchar2(50 ) NOT NULL,
  "Sequencing_Institution" Varchar2(50 ) NOT NULL,
  "Experimenter" Varchar2(50 ) NOT NULL,
  "Collection_Date" Date NOT NULL
)
/

-- Add keys for table EXPERIMENT_RELATED_INFORMATION

ALTER TABLE "EXPERIMENT_RELATED_INFORMATION" ADD CONSTRAINT "PK_EXPERIMENT_RELATED_INFORMATION" PRIMARY KEY ("Experiment_Identifier")
/

-- Table BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION

CREATE TABLE "BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION"(
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

-- Add keys for table BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION

ALTER TABLE "BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION" ADD CONSTRAINT "PK_BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION" PRIMARY KEY ("BI_Protocol_Identifier")
/

-- Table QUALITY_CHECK

CREATE TABLE "QUALITY_CHECK"(
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

-- Add keys for table QUALITY_CHECK

ALTER TABLE "QUALITY_CHECK" ADD CONSTRAINT "PK_QUALITY CHECK" PRIMARY KEY ("QC_Identifier")
/

-- Table GENOMIC_ALTERATION

CREATE TABLE "GENOMIC_ALTERATION"(
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
  "Codon" Clob,
  "Exon" Varchar2(10 ),
  "HGVS_Genomic_Change" Clob NOT NULL,
  "HGVS_Coding_Change" Clob,
  "HGVS_Protein_Change" Clob,
  "HGVS_Version" Varchar2(20 ) NOT NULL,
  "dbSNP_ID" Varchar2(20 ),
  "dbVar_ID" Varchar2(20 ),
  "Genome_Build" Varchar2(20 ),
  "Genomic_Source" Varchar2(10 ) NOT NULL,
  "HGNC_Gene_Symbol" Varchar2(20 ),
  "Entrez_ID" Integer,
  "Ensembl_ID" Char(15 ),
  "Genotype" Char(3 ),
  "clinVar_Variant_ID" Varchar2(20 ),
  "COSMIC_ID" Varchar2(10 ),
  "Molecular_Effect" Varchar2(50 ),
  "Variant_Type" Varchar2(20 ) NOT NULL,
  "Functional_Domain" Varchar2(50 )
)
/

-- Add keys for table GENOMIC_ALTERATION

ALTER TABLE "GENOMIC_ALTERATION" ADD CONSTRAINT "PK_GENOMIC_ALTERATION" PRIMARY KEY ("Genomic_Alteration_Identifier")
/

-- Table CLINICAL ANNOTATION

CREATE TABLE "CLINICAL_ANNOTATION"(
  "Clinical_Annotation_Identifier" Integer GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  "Genomic_Alteration_Identifier" Integer NOT NULL,
  "Biomarker_Datasource" Varchar2(255 ) NOT NULL,
  "Biomarker_Name" Varchar2(50 ) NOT NULL
)
/

-- Add keys for table CLINICAL_ANNOTATION

ALTER TABLE "CLINICAL_ANNOTATION" ADD CONSTRAINT "PK_CLINICAL_ANNOTATION" PRIMARY KEY ("Clinical_Annotation_Identifier")
/

-- Table MICROSATELLITE_INSTABILITY

CREATE TABLE "MICROSATELLITE_INSTABILITY"(
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

-- Add keys for table MICROSATELLITE_INSTABILITY

ALTER TABLE "MICROSATELLITE_INSTABILITY" ADD CONSTRAINT "PK_MICROSATELLITE_INSTABILITY" PRIMARY KEY ("MSI_Identifier")
/

