# Django 6.1 needs Python 3.12 or newer, so this uses 3.13 instead of the tutorial's 3.11.
FROM python:3.13-slim

LABEL org.opencontainers.image.source=https://github.com/JadMoh123/eece430-assignment6-ai-agent

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

# The Gemini key is not baked into the image. Pass it when starting the container:
#   docker run -p 8000:8000 -e GEMINI_API_KEY=your-key <image>
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
