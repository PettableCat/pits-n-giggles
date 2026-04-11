# ---- Stage 1: Build dependencies ----
FROM python:3.12-slim AS builder

RUN pip install --no-cache-dir poetry==2.1.3

WORKDIR /app

# Copy dependency files first for layer caching
COPY pyproject.toml poetry.lock ./

# Configure poetry: no virtualenv in container, no interaction
RUN poetry config virtualenvs.create false \
    && poetry install --without dev --no-root --no-interaction --no-ansi

# ---- Stage 2: Runtime ----
FROM python:3.12-slim

# Install minimal runtime deps for compiled wheels (zmq, gevent, etc.)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libgl1 \
        libegl1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application source
COPY apps/ ./apps/
COPY lib/ ./lib/
COPY meta/ ./meta/
COPY assets/ ./assets/

# Default ports (primary session). Multi-session opens additional ports from config.
# Use network_mode: host in docker-compose for multi-session support.
EXPOSE 4767/tcp 4768/tcp 20777/udp

# Headless container settings
ENV PYTHONUNBUFFERED=1 \
    QT_QPA_PLATFORM=offscreen \
    PNG_HEADLESS=1 \
    PNG_HTTP_PORT=4768

# Run as non-root user for security (CIS Docker Benchmark 4.1)
RUN useradd --create-home --shell /bin/bash appuser
USER appuser

HEALTHCHECK --interval=30s --timeout=5s \
    CMD python -c "import os,urllib.request; urllib.request.urlopen(f'http://localhost:{os.environ.get(\"PNG_HTTP_PORT\",\"4768\")}/')" || exit 1

CMD ["python", "-m", "apps.backend"]
