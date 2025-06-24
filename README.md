# GSE21942 Microarray Data Analysis and GSEA Preparation

## Project Overview

This project processes raw microarray data from the GEO dataset [GSE21942](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21942), which contains peripheral blood mononuclear cell (PBMC) expression profiles from 15 healthy controls and 12 multiple sclerosis (MS) patients.

The aim is to preprocess the raw Affymetrix CEL files, normalize the data, and prepare input files for Gene Set Enrichment Analysis (GSEA), including `.gct` and `.cls` files. The KEGG pathways gene sets can then be used for pathway enrichment analysis.

---

## Data Description

- **Dataset**: GSE21942  
- **Platform**: GPL570 [Affymetrix Human Genome U133 Plus 2.0 Array](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL570)  
- **Samples**: 27 total (15 controls, 12 MS patients including technical replicates)  
- **Raw data**: Affymetrix CEL files (compressed as `.CEL.gz` in `GSE21942_RAW.tar`)  

---

## Repository Contents

- `GSE21942_GSEA_processing.R` — R script to extract CEL files, perform RMA normalization, and create `.gct` and `.cls` files for GSEA  
- `README.md` — This documentation file  
- `GSEA_files/` — Folder containing the generated `.gct` and `.cls` files ready for GSEA input  
- 

---

## How to Use

### 1. Setup R Environment

Install necessary R packages:

```r
install.packages("BiocManager")
BiocManager::install("affy")
````


### 2. Run the Data Processing Script

- Download and extract raw CEL files (`GSE21942_RAW.tar`) manually or let the script handle extraction.

- Run `GSE21942_GSEA_processing.R` to:
  - Load CEL files
  - Normalize expression with RMA
  - Generate expression matrix
  - Create GSEA input files (`.gct` and `.cls`)


### 3. Run GSEA

- Download the KEGG pathways gene sets file from MSigDB C2 KEGG collection - (https://data.broadinstitute.org/gsea-msigdb/msigdb/release/2023.1.Hs/c2.cp.kegg.v2023.1.Hs.symbols.gmt).
  
- The file `c2.cp.kegg.v2023.1.Hs.symbols.gmt` (included in this repository) contains curated human KEGG pathways in gene symbol format.  
  It helps identify which known biological pathways are enriched in the multiple sclerosis gene expression data.

- Use the generated `.gct`, `.cls`, and `.gmt` files as input in the GSEA desktop application or command line.

---

## Notes

- The `.cls` file defines the sample phenotypes (Control vs. MS).
- Make sure the sample IDs match between expression data and phenotype labels.
- This analysis helps identify pathways enriched in MS patients compared to controls.

---
## Raw Data

Raw microarray CEL files are not included in this repository due to size and copyright restrictions.

You can download the raw data from the GEO database using the accession [GSE21942](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21942).

A script (`GSE21942_GSEA_processing.R`) is provided to process these raw files once downloaded.

## GSEA Output

The full GSEA output folder is not included to keep the repository size manageable.

Key summary results and plots are provided in the `GSEA_results_summary/` directory for reference.

The input files (`.gct`, `.cls`, and `.gmt`) are included to allow reproduction of the analysis.


## References

- GEO Dataset: GSE21942  
- GPL Platform: GPL570  
- Affymetrix RMA normalization: affy package documentation  
- GSEA: Broad Institute GSEA homepage  

