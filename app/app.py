from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def home():
    return {
        "message": "Hello from Docker + Terraform + FastAPI",
        "author": "Krishna Jaiswal",
        "project": " Portfolio"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }