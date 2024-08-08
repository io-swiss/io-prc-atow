#!/bin/bash

set -e

# ------------------------------------------------------------------------------
#
# run_io_template_app_dev.sh: Process IO-TEMPLATE-APP tasks.
#
# ------------------------------------------------------------------------------

export ENV_FOR_DYNACONF=dev

export IO_AERO_TASK=
export IO_AERO_TASK_DEFAULT=version

export PYTHONPATH=.

if [ -z "$1" ]; then
    echo "==================================================================="
    echo "version - Show the IO-TEMPLATE-APP version"
    echo "-------------------------------------------------------------------"
    # shellcheck disable=SC2162
    read -p "Enter the desired task [default: ${IO_AERO_TASK_DEFAULT}] " IO_AERO_TASK
    export IO_AERO_TASK=${IO_AERO_TASK}

    if [ -z "${IO_AERO_TASK}" ]; then
        export IO_AERO_TASK=${IO_AERO_TASK_DEFAULT}
    fi
else
    export IO_AERO_TASK=$1
fi

# Path to the log file
log_file="run_io_template_app_dev_${IO_AERO_TASK}.log"

# Function for logging messages
log_message() {
  local message="$1"
  # Format current date and time with timestamp
  timestamp=$(date +"%d.%m.%Y %H:%M:%S")
  # Write message with timestamp in the log file
  echo "$timestamp: $message" >> "$log_file"
}

# Check if logging_io_aero.log exists and delete it
if [ -f logging_io_aero.log ]; then
    rm -f logging_io_aero.log
fi

# Check if the file specified in logfile exists and delete it
if [ -f "${log_file}" ]; then
    rm -f "${log_file}"
fi

# Redirection of the standard output and the standard error output to the log file
exec > >(while read -r line; do log_message "$line"; done) 2> >(while read -r line; do log_message "ERROR: $line"; done)

echo "======================================================================="
echo "Start $0"
echo "-----------------------------------------------------------------------"
echo "IO_TEMPLATE_APP - Template for Application Repositories."
echo "-----------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF         : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH               : ${PYTHONPATH}"
echo "-----------------------------------------------------------------------"
echo "TASK                     : ${IO_AERO_TASK}"
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "======================================================================="


# ---------------------------------------------------------------------------
# version: Show the IO-TEMPLATE-APP version
# ---------------------------------------------------------------------------
# Task handling
# ---------------------------------------------------------------------------
if [[ "${IO_AERO_TASK}" =~ ^(version)$ ]]; then
    if ! ( python scripts/launcher.py -t "${IO_AERO_TASK}" ); then
        exit 255
    fi

# ---------------------------------------------------------------------------
# Program abort due to wrong input.
# ---------------------------------------------------------------------------
else
    echo "Processing of the script run_io_template_app_dev is aborted: unknown task='${IO_AERO_TASK}'"
    exit 255
fi

echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "-----------------------------------------------------------------------"
echo "End   $0"
echo "======================================================================="

# Close the log file
exec > >(while read -r line; do echo "$line"; done) 2> >(while read -r line; do echo "ERROR: $line"; done)

# Closing the log file
log_message "Script finished."
