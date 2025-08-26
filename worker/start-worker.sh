#!/bin/sh
set -e

# Use the standard MongoDB URI
if [ -z "$MONGO_URI_STANDARD" ]; then
  echo "MONGO_URI_STANDARD environment variable is not set"
  exit 1
fi

# Fetch one pending job ID from MongoDB using Python
JOB_ID=$(python3 - <<END
import os
from pymongo import MongoClient
client = MongoClient(os.environ.get("MONGO_URI_STANDARD"))
db = client["filesure"]
job = db.jobs.find_one({"jobStatus": "pending"})
if job:
    print(job["_id"])
END
)

# Exit if no pending job
if [ -z "$JOB_ID" ]; then
  echo "No pending job found"
  exit 0
fi

echo "Starting worker for job: $JOB_ID"

# Run the Python downloader with the job ID
python downloader.py "$JOB_ID"
