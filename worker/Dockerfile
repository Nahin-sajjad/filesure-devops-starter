FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y ca-certificates mongo-tools && update-ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY worker/downloader.py .

# Copy wrapper script
COPY worker/start-worker.sh /start-worker.sh
RUN chmod +x /start-worker.sh

# Expose metrics port
EXPOSE 9100

# Use wrapper as entrypoint
CMD ["/bin/sh", "/start-worker.sh"]
