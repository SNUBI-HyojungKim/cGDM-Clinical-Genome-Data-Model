Here, we provide a PGX CDS algorithm deveploped on cGDM to illustrate how implementation of the CGDM provides 
interactive clinical decision support when it linked in clinical information system.

You can run the source code(.sql file) via any demo dataset we provided, or your own dataset imported to the cGDM schema.

We recommend to create a index before you excute our computerized algorithm on your machine.

```sql
USE [your databasename];

ALTER TABLE `cGDM_1KGP3_Test`.`GENOMIC_ALTERATION` 
ADD INDEX `Idx_dbSNP_ref_alt_genotype` (`HGNC_ID` ASC, `dbSNP_ID` ASC, `Reference_Allele` ASC, `Alternative_Allele` ASC
                                        , `Genotype` ASC, `Position` ASC);
```

Minimal requirements for the implementation of demo database and DMBS setup are

: Storage size 
  - over 200 GB for 1000 genome project phase 3 CEU population 
  - 500MB for TCGA PAAD dataset
  - over 4GB RAM
  
 In our test enviromnet setting, provided query performance is under 0.05 sec.

: Test enviromnet
 - Server CPU: NVIDIA tesla c1060 / Quad core
 - RAM: 8GB
 - Starage: SAS 600GB/2
 - Dataset : 1000 Genome project phase 3 CEU popluation (99GB)
