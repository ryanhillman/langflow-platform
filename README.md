# Langflow Platform — Azure Deployment Demo

A containerized Langflow stack deployed to a public Azure VM using Docker Compose and a Caddy reverse proxy.

This project demonstrates practical cloud deployment skills including containerization, reverse proxy configuration, secure database isolation, and live public hosting.

## Live Demo

http://20.121.40.238/

Azure VM with Static Public IP
Reverse proxied via Caddy (Port 80 → 127.0.0.1:7860)


```mermaid
flowchart TD
    User["User Browser"]
    Caddy["Caddy Reverse Proxy\nPort 80"]
    Langflow["Langflow Container\nPort 7860"]
    Postgres["Postgres + pgvector\nDocker Volume (pgdata)"]
    Azure["Azure Linux VM\nStatic Public IP"]

    User -->|HTTP 80| Azure
    Azure --> Caddy
    Caddy -->|Reverse Proxy| Langflow
    Langflow -->|Internal Docker Network| Postgres

```

## Key Design Decisions

Postgres is NOT publicly exposed (no 5432 inbound rule).

Application port 7860 is not used directly by users.

Reverse proxy handles public traffic.

Secrets injected via .env (not committed).

Public IP configured as Static in Azure.

## Local Development
Prerequisites

Docker Desktop

Git

Run Locally
docker compose up -d
docker compose ps

Open:

http://localhost:7860
Stop
docker compose down

Do NOT use docker compose down -v unless you want to delete the Postgres volume.

## Azure Deployment Summary

High-level deployment steps used:

Create Azure Linux VM (Ubuntu)

Allow inbound ports:

22 (SSH)

80 (HTTP)

Install Docker + Docker Compose plugin

Clone repository onto VM

Create runtime .env file (not committed)

Start containers:

docker compose up -d

Install and configure Caddy reverse proxy:

:80 {
    reverse_proxy 127.0.0.1:7860
}

Restart Caddy:

sudo systemctl restart caddy

## Environment Variables (Example)

.env file (never committed):

LANGFLOW_DATABASE_URL=postgresql://langflow:langflow@postgres:5432/langflow
LANGFLOW_HOST=0.0.0.0
LANGFLOW_PORT=7860

AZURE_OPENAI_ENDPOINT=https://<your-resource>.openai.azure.com/
AZURE_OPENAI_API_KEY=<your-key>
AZURE_OPENAI_DEPLOYMENT=<deployment-name>
AZURE_OPENAI_API_VERSION=2024-02-15-preview

Secrets are managed outside version control.

## Skills Demonstrated

Docker container orchestration

Reverse proxy configuration (Caddy)

Cloud VM provisioning (Azure)

Network security via NSG rules

Database isolation from public internet

Static IP configuration

Environment-based secret management

Deploying AI tooling to cloud infrastructure

## Operational Commands

Check containers:

docker compose ps

View logs:

docker compose logs --tail 200 langflow

Restart services:

docker compose restart

## Portfolio Objective

This project showcases:

End-to-end deployment from local container development to public cloud hosting

Clean separation of proxy / application / database layers

Reproducible infrastructure pattern suitable for multi-cloud expansion

Practical AI platform deployment with secure architecture decisions
