FROM python:3.9-slim

WORKDIR /app

# Install minimal dependencies
RUN apt-get update && \
    apt-get install -y ca-certificates curl && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy Python requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy worker scripts
COPY worker/downloader.py .
COPY worker/start-worker.sh .

# Make shell script executable
RUN chmod +x start-worker.sh

# Expose metrics port if needed
EXPOSE 9100

# Default command
CMD ["./start-worker.sh"]
