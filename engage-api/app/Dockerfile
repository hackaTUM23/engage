FROM python:3.10-slim

WORKDIR /app

# Install dependencies (use --no-cache-dir to keep the image size small)
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

EXPOSE $PORT

# Note that Cloud Run assigns the IP address itself - that is why they are set to zero here.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT", "--proxy-headers"]
