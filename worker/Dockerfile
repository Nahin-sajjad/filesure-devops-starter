FROM python:3.9-slim
WORKDIR /app
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY worker/downloader.py .
COPY worker/entrypoint.sh .
RUN chmod +x /app/entrypoint.sh
EXPOSE 9100
ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]