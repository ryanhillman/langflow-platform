# Langflow Platform

A self-hosted [Langflow](https://github.com/langflow-ai/langflow) deployment backed by PostgreSQL with pgvector, packaged for local Docker Compose and AKS (Helm).

---

## Quick Start

```bash
docker compose up -d
```

Open <http://localhost:7860> in your browser.

---

## Troubleshooting

### Docker Desktop pipe error (`//./pipe/dockerDesktopLinuxEngine`)

**Symptom**

```
error during connect: Get "http://%2F%2F.%2Fpipe%2FdockerDesktopLinuxEngine/...":
open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.
```

**Fix**

1. Open **Docker Desktop** and wait until the whale icon in the system tray shows *"Docker Desktop is running"*.
2. If Docker Desktop is already open but the engine is stopped, go to **Settings → General** and click **Start**.
3. If the issue persists, restart the Docker Desktop service:
   ```powershell
   Restart-Service -Name "com.docker.service" -Force
   ```
4. Re-run `docker compose up -d`.

---

### Port checks

Before starting the stack, confirm the required ports are free.

**Langflow (7860)**

```bash
# Linux / macOS
lsof -i :7860

# Windows (PowerShell)
netstat -ano | findstr :7860
```

**PostgreSQL (5432)**

```bash
# Linux / macOS
lsof -i :5432

# Windows (PowerShell)
netstat -ano | findstr :5432
```

If a port is in use, either stop the conflicting process or change the host-side port mapping in `docker-compose.yml`:

```yaml
ports:
  - "7861:7860"   # map host 7861 → container 7860
```

---

### Viewing logs

**All services (follow mode)**

```bash
docker compose logs -f
```

**Single service**

```bash
docker compose logs -f langflow
docker compose logs -f postgres
```

**Last N lines only**

```bash
docker compose logs --tail=100 langflow
```
