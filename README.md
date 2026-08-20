# 🧬 Bioinformatics Pipeline 3.4 — 18S rRNA Phylogenetic Workflow

A reproducible command-line workflow for **18S rRNA sequence curation, multiple sequence alignment, alignment trimming, evolutionary model selection, and Maximum-Likelihood phylogenetic inference**.

This repository was prepared for **portfolio, educational, and reproducibility purposes** using only publicly available sequence data.

> ⚠️ No unpublished samples, internal identifiers, unpublished hosts, candidate species names, unpublished phylogenetic trees, genetic-distance results, or manuscript-specific conclusions are included.

---

## 📌 Overview

The pipeline automates the main steps of a molecular phylogenetic analysis:

```text
Public 18S rRNA sequences
        │
        ▼
FASTA curation
        │
        ▼
Multiple Sequence Alignment
        MAFFT
        │
        ▼
Alignment Trimming
        trimAl
        │
        ▼
Model Selection
        ModelFinder
        │
        ▼
Maximum-Likelihood Phylogeny
        IQ-TREE 3
        │
        ├── 1,000 SH-aLRT replicates
        └── 1,000 Ultrafast Bootstrap replicates
        │
        ▼
Final phylogenetic outputs