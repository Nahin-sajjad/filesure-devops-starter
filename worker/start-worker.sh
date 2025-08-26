#!/bin/sh
# Wrapper to fetch a pending job ID and start the worker

# Fetch a single pending job ID from MongoDB
JOB_ID=$(mongo "$MONGO_URI/filesure" --quiet --eval 'var job=db.jobs.findOne({jobStatus:"pending"}); job ? job._id.str : ""')

if [ -z "$JOB_ID" ]; then
  echo "No pending job found"
  exit 1
fi

echo "Starting worker for job: $JOB_ID"
python downloader.py $JOB_ID
