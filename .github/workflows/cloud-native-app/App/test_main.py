import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_health_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert "timestamp" in data
    assert "hostname" in data

def test_hello_endpoint():
    response = client.get("/api/hello")
    assert response.status_code == 200
    data = response.json()
    assert "message" in data
    assert "environment" in data
    assert data["environment"] == "dev"  # Default env