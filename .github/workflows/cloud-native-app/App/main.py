from fastapi import FastAPI
from datetime import datetime
import socket
import os

app = FastAPI()

@app.get("/health")
def health():
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow(),
        "hostname": socket.gethostname()
    }

@app.get("/api/hello")
def hello():
    return {
        "message": "Hello from Cloud Native App!",
        "environment": os.getenv("ENV", "dev")
    }