

/*******************************************************************************************
DDL(Data definition language) script to create cGDM(Clinical Genome Data Model) version 1.0
********************************************************************************************
# Created: 26-Nov-2019
# Last revised: 03-DEC-2019
# Database: SQL Server, tested Model: SQL Server 2017
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

/******************** Table CLINICAL_IDENTIFIER ********************/

CREATE TABLE [CLINICAL_IDENTIFIER]
(
 [Subject_Identifier] Int IDENTITY NOT NULL,
 [Patient Number] Varchar(20) NOT NULL,
 [Institution_Identifier] Char(20) NOT NULL,
 [Order_Identifier] Char(20) NOT NULL,
 [Clinician_Identifier] Char(20) NOT NULL,
 [Submission_Date] Datetime2 NOT NULL
)
go

-- Add keys for table CLINICAL_IDENTIFIER

ALTER TABLE [CLINICAL_IDENTIFIER] ADD CONSTRAINT [PK_CLINICAL_IDENTIFIER] PRIMARY KEY ([Subject_Identifier])
go

/******************** Table EXPERIMENT_RELATED_INFORMATION ********************/

CREATE TABLE [EXPERIMENT_RELATED_INFORMATION]
(
 [Experiment_Identifier] Int IDENTITY NOT NULL,
 [Subject_Identifier] Int NOT NULL,
 [Test_Description] Text NULL,
 [Sequencing_Type] Varchar(50) NOT NULL,
 [Platform_Technology] Varchar(20) NOT NULL,
 [Sequencer] Varchar(50) NOT NULL,
 [Sequencing_Institution] Varchar(50) NOT NULL,
 [Experimenter] Varchar(50) NOT NULL,
 [Collection_Date] Datetime2 NOT NULL
)
go

-- Add keys for table EXPERIMENT_RELATED_INFORMATION

ALTER TABLE [EXPERIMENT_RELATED_INFORMATION] ADD CONSTRAINT [PK_EXPERIMENT_RELATED_INFORMATION] PRIMARY KEY ([Experiment_Identifier])
go

/******************** Table BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION ********************/

CREATE TABLE [BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION]
(
 [BI_Protocol_Identifier] Int IDENTITY NOT NULL,
 [Experiment_Identifier] Int NOT NULL,
 [Pipeline_Name] Varchar(50) NOT NULL,
 [Step] Int NOT NULL,
 [Tool] Varchar(50) NOT NULL,
 [Parameter] Varchar(50) NOT NULL,
 [Datasource_Origin] Varchar(50) NOT NULL,
 [Datasource_Version] Varchar(50) NULL,
 [Datasource_Build] Varchar(50) NULL,
 [Analytics_Institution] Varchar(50) NOT NULL,
 [Bioinformatician] Varchar(50) NOT NULL,
 [Received_Date] Datetime2 NOT NULL,
 [Documentation_Date] Datetime2 NOT NULL
)
go

-- Add keys for table BIOINFORMATICS PROTOCOL RELATED INFORMATION

ALTER TABLE [BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION] ADD CONSTRAINT [PK_BIOINFORMATICS_PROTOCOL_RELATED_INFORMATION] PRIMARY KEY ([BI_Protocol_Identifier])
go

/******************** Table QUALITY_CHECK ********************/

CREATE TABLE [QUALITY_CHECK]
(
 [QC_Identifier] Int IDENTITY NOT NULL,
 [BI_Protocol_Identifier] Int NOT NULL,
 [Total_Reads] Bigint NOT NULL,
 [Total_Aligned_Reads] Bigint NULL,
 [Reads_Aligned_Percent] Real NULL,
 [Total_Bases] Bigint NULL,
 [Mapped_Bases] Bigint NULL,
 [Depth_Mean] Real NULL,
 [Depth_SD] Real NULL,
 [Target_Bases] Bigint NULL
)
go

-- Add keys for table QUALITY CHECK

ALTER TABLE [QUALITY CHECK] ADD CONSTRAINT [PK_QUALITY_CHECK] PRIMARY KEY ([QC_Identifier])
go

/******************** Table GENOMIC_ALTERATION ********************/

CREATE TABLE [GENOMIC_ALTERATION]
(
 [Genomic_Alteration_Identifier] Int IDENTITY NOT NULL,
 [BI_Protocol_Identifier] Int NOT NULL,
 [Position] Varchar(255) NOT NULL,
 [Reference_Allele] Varchar(255) NOT NULL,
 [Alternative_Allele] Varchar(255) NOT NULL,
 [Chromosome] Varchar(2) NOT NULL,
 [Cytogenetic_Location] Text NULL,
 [Codon] Text NOT NULL,
 [Exon] Varchar(10) NULL,
 [HGVS_Genomic_Change] Text NOT NULL,
 [HGVS_Coding_Change] Text NULL,
 [HGVS_Protein_Change] Text NULL,
 [HGVS_Version] Varchar(20) NOT NULL,
 [dbSNP_ID] Varchar(20) NULL,
 [dbVar_ID] Varchar(20) NULL,
 [Genome_Build] Varchar(20) NULL,
 [Genomic_Source] Varchar(10) NOT NULL,
 [HGNC_ID] Varchar(10) NULL,
 [Entrez_ID] Int NULL,
 [Ensembl_ID] Char(15) NULL,
 [Genotype] Char(3) NULL,
 [clinVar_Variant_ID] Varchar(20) NULL,
 [COSMIC_ID] Varchar(10) NULL,
 [Molecular_Effect] Varchar(20) NULL,
 [Variant_Type] Varchar(20) NOT NULL,
 [Functional_Domain] Varchar(50) NULL
)
go

-- Add keys for table GENOMIC_ALTERATION

ALTER TABLE [GENOMIC_ALTERATION] ADD CONSTRAINT [PK_GENOMIC_ALTERATION] PRIMARY KEY ([Genomic_Alteration_Identifier])
go

/******************** Table CLINICAL_ANNOTATION ********************/

CREATE TABLE [CLINICAL_ANNOTATION]
(
 [Clinical_Annotation_Identifier] Int IDENTITY NOT NULL,
 [Genomic_Alteration_Identifier] Int NOT NULL,
 [Biomarker_Datasource] Varchar(255) NOT NULL,
 [Biomarker_Name] Varchar(50) NOT NULL
)
go

-- Add keys for table CLINICAL ANNOTATION

ALTER TABLE [CLINICAL_ANNOTATION] ADD CONSTRAINT [PK_CLINICAL_ANNOTATION] PRIMARY KEY ([Clinical_Annotation_Identifier])
go

/******************** Table MICROSATELLITE_INSTABILITY ********************/

CREATE TABLE [MICROSATELLITE_INSTABILITY]
(
 [MSI_Identifier] Int IDENTITY NOT NULL,
 [BI_Protocol_Identifier] Int NOT NULL,
 [Biomarker_Name] Varchar(50) NOT NULL,
 [MSI_Phenotype] Varchar(50) NOT NULL,
 [MSI_Marker_Name] Varchar(20) NOT NULL,
 [MSI_Marker_Status] Varchar(20) NOT NULL
)
go

-- Add keys for table MICROSATELLITE_INSTABILITY

ALTER TABLE [MICROSATELLITE_INSTABILITY] ADD CONSTRAINT [PK_MICROSATELLITE_INSTABILITY] PRIMARY KEY ([MSI_Identifier])
go

/******************** Table TUMOR_MUTATION_BURDEN ********************/

CREATE TABLE [TUMOR_MUTATION_BURDEN]
(
 [TMB_Identifier] Int IDENTITY NOT NULL,
 [BI_Protocol_Identifier] Int NOT NULL,
 [Biomarker_Name] Varchar(50) NOT NULL,
 [Burden_Call] Varchar(20) NOT NULL,
 [Burden_Score] Real NOT NULL,
 [Burden_Unit] Varchar(20) NOT NULL
)
go

-- Add keys for table TUMOR_MUTATION_BURDEN

ALTER TABLE [TUMOR_MUTATION_BURDEN] ADD CONSTRAINT [PK_TUMOR_MUTATION_BURDEN] PRIMARY KEY ([TMB_Identifier])
go
