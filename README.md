# EECE430 Assignment 6: AI Inventory Agent with GitHub Actions CI/CD

**Jad Moharam, ID 202400899**

A Django web app with an AI agent (Google Gemini) that checks and updates the stock and prices of a small hardware warehouse. The agent calls tools (`check_stock`, `list_items`, `add_item`, `remove_stock`, `delete_item`) that read and write the SQLite database.

## CI/CD pipeline

The pipeline is defined in [`.github/workflows/ci.yml`](.github/workflows/ci.yml). It runs on every push to `main`, and can also be started by hand from the Actions tab.

| Job | Runs on | What it does |
| --- | --- | --- |
| `test` (CI) | GitHub's Ubuntu 24.04 machine | Installs the requirements, runs `manage.py check` and `manage.py test`, builds the Docker image and pushes it to `ghcr.io/jadmoh123/eece430-assignment6-ai-agent:latest` |
| `deploy` (CD) | Self-hosted runner on my PC (label `ai-agent-deploy`) | Checks Docker, pulls the new image and replaces the `ai-agent-app` container on http://localhost:8000 |

`deploy` only runs after `test` succeeds.

## The Gemini API key

The key is **not** stored in the repository or the image. It is saved as the repository secret `GEMINI_API_KEY` and passed to the container by the `deploy` job when it starts. The `test` job uses a placeholder key, because the tests never call Gemini.

## Run the deployment locally

1. Start Docker Desktop (Linux containers).
2. Start the self-hosted runner: `C:\actions-runner\run.cmd`
3. Push a change to `main`, wait for `test` and `deploy` to pass, then open http://localhost:8000

## Run the image by hand

```bash
docker pull ghcr.io/jadmoh123/eece430-assignment6-ai-agent:latest
docker run -d -p 8000:8000 -e GEMINI_API_KEY=your-key ghcr.io/jadmoh123/eece430-assignment6-ai-agent:latest
```
