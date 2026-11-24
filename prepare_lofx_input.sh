#!/usr/bin/env bash
# ======================================================================
# prepare_lofx_input.sh
# Prepare a LoFX input file from a VCF (GRCh38) with ANNOVAR.
#
# Usage:
#   bash prepare_lofx_input.sh  input.vcf  /path/to/annovar  output_prefix
#
# Requirements:
#   - ANNOVAR (free for academic use; registration at
#     https://annovar.openbioinformatics.org)
#   - Perl (installed by default on Linux and macOS)
#
# The first run downloads the annotation databases into
# /path/to/annovar/humandb (dbNSFP is large; allow several tens of GB
# of disk space and some hours for the download).
#
# Output:
#   output_prefix.hg38_multianno.txt  -> upload this file to the LoFX GUI
# ======================================================================
set -euo pipefail

VCF="$1"
ANNOVAR_DIR="$2"
OUT="$3"
DB="${ANNOVAR_DIR}/humandb"
BUILD="hg38"

# ---------------------------------------------------------------
# 1) Download databases (only if not already present)
#    Use the same database versions as in the LoFX manuscript.
# ---------------------------------------------------------------
download () {
    local name="$1"
    if ! ls "${DB}/${BUILD}_${name}"* >/dev/null 2>&1; then
        echo "Downloading ${name} ..."
        perl "${ANNOVAR_DIR}/annotate_variation.pl" -buildver "${BUILD}" \
             -downdb -webfrom annovar "${name}" "${DB}/"
    fi
}
download refGene
download exac03
download 1000g2015aug
download dbnsfp47a

# ---------------------------------------------------------------
# 2) Annotate the VCF
# ---------------------------------------------------------------
perl "${ANNOVAR_DIR}/table_annovar.pl" "${VCF}" "${DB}/" \
     -buildver "${BUILD}" \
     -out "${OUT}" \
     -remove \
     -protocol refGene,exac03,1000g2015aug_all,dbnsfp47a \
     -operation g,f,f,f \
     -nastring . \
     -vcfinput \
     -polish

echo ""
echo "Done. Upload ${OUT}.${BUILD}_multianno.txt to the LoFX web interface."
echo "Only stop-gain, stop-loss and start-loss variants are scored by LoFX."
