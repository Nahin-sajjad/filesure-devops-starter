#!/bin/sh
set -e

# Check MongoDB URI
if [ -z "$MONGO_URI" ]; then
  echo "MONGO_URI environment variable is not set"
  exit 1
fi

# Use Python one-liner to get a pending job ID
JOB_ID=$(python3 - <<END
import os
from pymongo import MongoClient
client = MongoClient(os.environ.get("MONGO_URI"))
db = client["filesure"]
job = db.jobs.find_one({"jobStatus":"pending"})
if job:
    print(job["_id"])
END
)

if [ -z "$JOB_ID" ]; then
  echo "No pending job found"
  exit 0
fi

echo "Starting worker for job: $JOB_ID"

# Run the existing downloader
python downloader.py "$JOB_ID"
