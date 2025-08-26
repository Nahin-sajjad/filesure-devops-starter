# Use a lightweight Python base
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg ca-certificates && \
    # Add MongoDB repo and install mongo shell
    curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/debian buster/mongodb-org/6.0 main" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    apt-get update && \
    apt-get install -y mongodb-org-shell && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy Python requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy worker code and wrapper script
COPY worker/downloader.py .
COPY worker/start-worker.sh .

# Make wrapper executable
RUN chmod +x start-worker.sh

# Expose optional metrics port
EXPOSE 9100

# Start the worker using the wrapper
CMD ["./start-worker.sh"]
