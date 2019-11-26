
/*******************************************************************************************
DDL(Data definition language) script to create cGDM(Clinical Genome Data Model) version 1.0
********************************************************************************************
# Created: 26-Nov-2019
# Last revised: 26-Nov-2019
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

-- Table CLINICAL IDENTIFIER

CREATE TABLE [CLINICAL IDENTIFIER]
(
 [Subject Identifier] Int IDENTITY NOT NULL,
 [Patient Number] Varchar(20) NOT NULL,
 [Institution Identifier] Char(20) NOT NULL,
 [Order_Identifier] Char(20) NOT NULL,
 [Clinician_Identifier] Char(20) NOT NULL,
 [Submission_Date] Datetime2 NOT NULL
)
go

-- Add keys for table CLINICAL IDENTIFIER

ALTER TABLE [CLINICAL IDENTIFIER] ADD CONSTRAINT [PK_CLINICAL IDENTIFIER] PRIMARY KEY ([Subject Identifier])
go

-- Table EXPERIMENT RELATED INFORMATION

CREATE TABLE [EXPERIMENT RELATED INFORMATION]
(
 [Experiment_Identifier] Int IDENTITY NOT NULL,
 [Subject_Identifier] Int NOT NULL,
 [Order_Identifier] Varchar(20) NOT NULL,
 [Test_Description] Text NULL,
 [Sequencing_Type] Varchar(50) NOT NULL,
 [Platform_Technology] Varchar(20) NOT NULL,
 [Sequencer] Varchar(50) NOT NULL,
 [Sequencing_Institution] Varchar(50) NOT NULL,
 [Experimenter] Varchar(50) NOT NULL,
 [Collection_Date] Datetime2 NOT NULL
)
go

-- Add keys for table EXPERIMENT RELATED INFORMATION

ALTER TABLE [EXPERIMENT RELATED INFORMATION] ADD CONSTRAINT [PK_EXPERIMENT RELATED INFORMATION] PRIMARY KEY ([Experiment_Identifier])
go

-- Table BIOINFORMATICS PROTOCOL RELATED INFORMATION

CREATE TABLE [BIOINFORMATICS PROTOCOL RELATED INFORMATION]
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

ALTER TABLE [BIOINFORMATICS PROTOCOL RELATED INFORMATION] ADD CONSTRAINT [PK_BIOINFORMATICS PROTOCOL RELATED INFORMATION] PRIMARY KEY ([BI_Protocol_Identifier])
go

-- Table QUALITY CHECK

CREATE TABLE [QUALITY CHECK]
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

ALTER TABLE [QUALITY CHECK] ADD CONSTRAINT [PK_QUALITY CHECK] PRIMARY KEY ([QC_Identifier])
go

-- Table GENOMIC ALTERATION

CREATE TABLE [GENOMIC ALTERATION]
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

-- Add keys for table GENOMIC ALTERATION

ALTER TABLE [GENOMIC ALTERATION] ADD CONSTRAINT [PK_GENOMIC ALTERATION] PRIMARY KEY ([Genomic_Alteration_Identifier])
go

-- Table CLINICAL ANNOTATION

CREATE TABLE [CLINICAL ANNOTATION]
(
 [Clinical_Annotation_Identifier] Int IDENTITY NOT NULL,
 [Genomic_Alteration_Identifier] Int NOT NULL,
 [Biomarker_Datasource] Varchar(255) NOT NULL,
 [Biomarker_Name] Varchar(50) NOT NULL
)
go

-- Add keys for table CLINICAL ANNOTATION

ALTER TABLE [CLINICAL ANNOTATION] ADD CONSTRAINT [PK_CLINICAL ANNOTATION] PRIMARY KEY ([Clinical_Annotation_Identifier])
go

-- Table MICROSATELLITE INSTABILITY

CREATE TABLE [MICROSATELLITE INSTABILITY]
(
 [MSI_Identifier] Int IDENTITY NOT NULL,
 [BI_Protocol_Identifier] Int NOT NULL,
 [Biomarker_Name] Varchar(50) NOT NULL,
 [MSI_Phenotype] Varchar(50) NOT NULL,
 [MSI_Marker_Name] Varchar(20) NOT NULL,
 [MSI_Marker_Status] Varchar(20) NOT NULL
)
go

-- Add keys for table MICROSATELLITE INSTABILITY

ALTER TABLE [MICROSATELLITE INSTABILITY] ADD CONSTRAINT [PK_MICROSATELLITE INSTABILITY] PRIMARY KEY ([MSI_Identifier])
go

-- Table TUMOR MUTATION BURDEN

CREATE TABLE [TUMOR MUTATION BURDEN]
(
 [TMB_Identifier] Int IDENTITY NOT NULL,
 [BI_Protocol_Identifier] Int NOT NULL,
 [Biomarker_Name] Varchar(50) NOT NULL,
 [Burden_Call] Varchar(20) NOT NULL,
 [Burden_Score] Real NOT NULL,
 [Burden_Unit] Varchar(20) NOT NULL
)
go

-- Add keys for table TUMOR MUTATION BURDEN

ALTER TABLE [TUMOR MUTATION BURDEN] ADD CONSTRAINT [PK_TUMOR MUTATION BURDEN] PRIMARY KEY ([TMB_Identifier])
go




