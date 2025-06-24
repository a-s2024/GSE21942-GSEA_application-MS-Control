# =============================================================================
# GSE21942: Preprocessing + Normalization + GCT & CLS File Creation for GSEA
# =============================================================================

# ------------------ Setup ------------------
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
if (!requireNamespace("affy", quietly = TRUE)) BiocManager::install("affy")
library(affy)

# I already installed the Raw TAR file from:
# https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21942

# Define paths (change if needed)
raw_tar <- "GSE21942_RAW.tar"
cel_dir <- "GSE21942_CEL"
output_dir <- file.path(cel_dir, "GSEA_files")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# ------------------ 1. Extract CEL Files ------------------
if (!dir.exists(cel_dir)) untar(raw_tar, exdir = cel_dir)

# ------------------ 2. Read and Normalize ------------------
setwd(cel_dir)
eset <- rma(ReadAffy())
expr <- exprs(eset)
write.csv(expr, file = file.path(cel_dir, "GSE21942_rma_expression.csv"))

# ------------------ 3. Group Labels ------------------
# Manual class labels from GEO (15 Control, 12 MS)
sample_ids <- gsub("\\.CEL(\\.gz)?$", "", sampleNames(eset), ignore.case = TRUE)
group_labels <- c(rep("Control", 15), rep("MS", 12))
stopifnot(length(group_labels) == length(sample_ids))

# ------------------ 4. Write GCT File ------------------
write_gct <- function(expr, file) {
  df <- data.frame(Name = rownames(expr), Description = "na", expr)
  writeLines(c("#1.2", paste(nrow(expr), ncol(expr), sep = "\t")), file)
  write.table(df, file, sep = "\t", quote = FALSE, row.names = FALSE, col.names = TRUE, append = TRUE)
}
write_gct(expr, file.path(output_dir, "GSE21942_expression.gct"))

# ------------------ 5. Write CLS File ------------------
write_cls <- function(groups, file) {
  writeLines(c(
    paste(length(groups), length(unique(groups)), "1"),
    paste("#", paste(unique(groups), collapse = " ")),
    paste(groups, collapse = " ")
  ), file)
}
write_cls(group_labels, file.path(output_dir, "GSE21942_phenotype.cls"))

# ------------------ 6. GMT File ------------------
cat("\nDone. GCT and CLS files saved in:", output_dir, "\n")
cat("Download GMT file (in this case KEGG): https://www.gsea-msigdb.org/gsea/msigdb\n")
