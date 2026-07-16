from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def home():
    return {
        "message": "🚀 FastAPI application is running successfully!",
        "project": "Docker + Terraform Deployment",
        "status": "Healthy"
    }


@app.get("/health")
def health():
    return {
        "status": "OK"
    }