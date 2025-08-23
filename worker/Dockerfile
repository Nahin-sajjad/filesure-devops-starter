FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY worker/downloader.py .
EXPOSE 9100
CMD ["python", "downloader.py"]