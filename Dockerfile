# Stage 1: Build dependencies
FROM python:3.10-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libmariadb-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy application requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# Stage 2: Runtime
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy only the installed dependencies from the builder stage
COPY --from=builder /install /usr/local

# Copy entrypoint script and make it executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Copy application code
COPY . .

# Define the entrypoint and command
ENTRYPOINT ["/app/entrypoint.sh"]

# Expose the necessary port
EXPOSE 8000
