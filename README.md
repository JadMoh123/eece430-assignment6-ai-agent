# EECE430 Assignment 5: AI Inventory Agent in Docker

**Jad Moharam, ID 202400899**

A Django web app with an AI agent (Google Gemini) that checks and updates the stock and prices of a small hardware warehouse. The agent calls tools (`check_stock`, `list_items`, `add_item`, `remove_stock`, `delete_item`) that read and write the SQLite database.

## Files added for Docker

| File | Purpose |
| --- | --- |
| `Dockerfile` | Blueprint for the image (Python 3.13 slim, installs requirements, runs the Django server on port 8000) |
| `requirements.txt` | Python dependencies: Django, google-genai, python-dotenv |
| `.dockerignore` | Keeps `.env` (the API key), caches and PDFs out of the image |

The Gemini API key is **not** stored in the repository or the image. It is passed in when the container starts.

## 1. Build and run the image locally

```bash
docker build -t inventory-agent .
docker run -p 8000:8000 -e GEMINI_API_KEY=your-key -d inventory-agent
```

Open http://localhost:8000

## 2. Push the image to GitHub

The image is published to GitHub Container Registry and linked to this repository.

```bash
docker tag inventory-agent ghcr.io/jadmoh123/eece430-assignment5-ai-agent:latest
docker login ghcr.io
docker push ghcr.io/jadmoh123/eece430-assignment5-ai-agent:latest
```

## 3. Run the image from GitHub

```bash
docker login ghcr.io
docker pull ghcr.io/jadmoh123/eece430-assignment5-ai-agent:latest
docker run -p 8000:8000 -e GEMINI_API_KEY=your-key -d ghcr.io/jadmoh123/eece430-assignment5-ai-agent:latest
```

`docker login ghcr.io` asks for your GitHub username and a personal access token with the `read:packages` scope, because the package is private.

Open http://localhost:8000

## Stop the container

```bash
docker ps
docker stop <container-id>
```
