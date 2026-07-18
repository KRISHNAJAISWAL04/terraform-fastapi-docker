from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def home():
    return {
        "message": "Hello from Docker + Terraform + FastAPI",
        "author": "Krishna Jaiswal",
        "project": " my Portfolio"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }