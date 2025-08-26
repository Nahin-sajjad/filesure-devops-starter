#!/bin/sh
set -e

# This script fetches a pending job from MongoDB and runs the worker

if [ -n "$JOB_ID" ]; then
    echo "Starting worker for JOB_ID from environment: $JOB_ID"
    python downloader.py "$JOB_ID"
    exit 0
fi

# Fetch one pending job ID from MongoDB
JOB_ID=$(mongo --quiet "$MONGO_URI" --eval 'db.jobs.findOne({jobStatus:"pending"},{_id:1})["_id"].str')

if [ -z "$JOB_ID" ]; then
    echo "No pending job found, exiting."
    exit 0
fi

echo "Starting worker for job ID: $JOB_ID"
python downloader.py "$JOB_ID"
