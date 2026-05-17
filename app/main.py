from fastapi import FastAPI
from datetime import datetime, timezone
import socket
import os

from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()

# Health endpoints
@app.get("/health")
def health():
    return {
        "status": "healthy",
        "timestamp": datetime.now(timezone.utc),
        "hostname": socket.gethostname(),
    }


@app.get("/api/hello")
def hello():
    return {
        "message": "Hello from Cloud Native App!",
        "environment": os.getenv("ENV", "dev"),
    }


# Prometheus metrics endpoint
Instrumentator().instrument(app).expose(app, endpoint="/metrics")
