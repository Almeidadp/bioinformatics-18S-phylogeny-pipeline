#!/usr/bin/env bash

set -euo pipefail

# ==========================================================
# Bioinformatics Pipeline 3.4 — Public Version
# 18S rRNA phylogenetic workflow
#
# This version is intended for public repositories and uses
# only public demonstration sequences.
# ==========================================================

INPUT="input/input_sequences.fasta"
ALIGNMENT_DIR="alignment"
PHYLOGENY_DIR="phylogeny"

MAFFT_OUT="${ALIGNMENT_DIR}/alignment_mafft.fasta"
TRIMMED_OUT="${ALIGNMENT_DIR}/alignment_trimmed.fasta"
IQTREE_PREFIX="${PHYLOGENY_DIR}/public_18S"

THREADS="AUTO"

echo "=============================================="
echo " Bioinformatics Pipeline 3.4 — Public Version "
echo "=============================================="

# ----------------------------------------------------------
# 1. Check dependencies
# ----------------------------------------------------------

for tool in mafft trimal iqtree3; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "ERROR: Required tool '$tool' was not found in PATH."
        exit 1
    fi
done

# ----------------------------------------------------------
# 2. Check input file
# ----------------------------------------------------------

if [[ ! -f "$INPUT" ]]; then
    echo "ERROR: Input FASTA file not found:"
    echo "       $INPUT"
    exit 1
fi

# ----------------------------------------------------------
# 3. Create output directories
# ----------------------------------------------------------

mkdir -p "$ALIGNMENT_DIR"
mkdir -p "$PHYLOGENY_DIR"

# ----------------------------------------------------------
# 4. MAFFT — Multiple sequence alignment
# ----------------------------------------------------------

echo
echo "[1/3] Running MAFFT..."

mafft \
    --auto \
    "$INPUT" \
    > "$MAFFT_OUT"

echo "MAFFT output:"
echo "  $MAFFT_OUT"

# ----------------------------------------------------------
# 5. trimAl — Alignment trimming
# ----------------------------------------------------------

echo
echo "[2/3] Running trimAl..."

trimal \
    -in "$MAFFT_OUT" \
    -out "$TRIMMED_OUT" \
    -automated1

echo "trimAl output:"
echo "  $TRIMMED_OUT"

# ----------------------------------------------------------
# 6. IQ-TREE 3 — Model selection + ML phylogeny
# ----------------------------------------------------------

echo
echo "[3/3] Running IQ-TREE 3..."

iqtree3 \
    -s "$TRIMMED_OUT" \
    -m MFP \
    -bb 1000 \
    -alrt 1000 \
    -nt "$THREADS" \
    -pre "$IQTREE_PREFIX"

echo
echo "=============================================="
echo " Pipeline completed successfully"
echo "=============================================="
echo
echo "Main outputs:"
echo "  ${IQTREE_PREFIX}.treefile"
echo "  ${IQTREE_PREFIX}.iqtree"
echo "  ${IQTREE_PREFIX}.log"
echo "  ${IQTREE_PREFIX}.contree"
