FROM python:3.9-slim
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy worker code
COPY worker/downloader.py .
COPY worker/start-worker.sh .
RUN chmod +x start-worker.sh

# Expose metrics port
EXPOSE 9100

# Use shell wrapper as entrypoint
CMD ["./start-worker.sh"]
