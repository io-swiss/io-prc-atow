#!/bin/bash
# This script activates the conda environment and executes the provided command.

# -----------------------------------------------------------------------------
# Activate the conda environment
# -----------------------------------------------------------------------------
source /opt/conda/etc/profile.d/conda.sh
conda activate ioprcatow

# -----------------------------------------------------------------------------
# Execute the provided command
# -----------------------------------------------------------------------------
exec "$@"
