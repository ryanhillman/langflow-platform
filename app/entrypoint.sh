#!/usr/bin/env bash
set -euo pipefail

HOST="${LANGFLOW_HOST:-0.0.0.0}"
PORT="${LANGFLOW_PORT:-7860}"

exec langflow run --host "${HOST}" --port "${PORT}"