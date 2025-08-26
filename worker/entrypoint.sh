#!/bin/bash
set -e

# Determine JOB_ID
if [ $# -eq 1 ]; then
    JOB_ID="$1"
elif [ -n "$JOB_ID" ]; then
    # JOB_ID already set via environment
    :
else
    # No JOB_ID provided
    echo "No JOB_ID provided. Exiting."
    exit 0
fi

echo "Starting Document Downloader for JOB_ID: $JOB_ID"

# Run the worker with the JOB_ID
exec python downloader.py "$JOB_ID"
