# Terraform + FastAPI + Docker

Ek simple DevOps portfolio project jo FastAPI app ko Docker container me run karta hai aur Terraform ke through AWS EC2 par deploy karta hai.

## Overview

Ye project 3 parts me split hai:

1. `app/` - FastAPI application aur Dockerfile
2. `terraform/` - EC2, security group, aur bootstrap automation
3. `userdata.sh` - EC2 boot hone ke baad Docker install karke app ko run karne ka script

## Features

- FastAPI REST API
- Dockerized application
- Terraform-based AWS EC2 provisioning
- EC2 startup par automatic app deployment
- Health check endpoint

## Architecture

`Client -> AWS EC2 (port 80) -> Docker container (port 8000) -> FastAPI app`

Terraform EC2 instance create karta hai, security group me SSH aur HTTP allow karta hai, aur `userdata.sh` ke through server par Docker install karke application container start karta hai.

## API Endpoints

- `GET /` - Welcome message
- `GET /health` - Basic health check

Example response:

```json
{
  "message": "Hello from Docker + Terraform + FastAPI",
  "author": "Krishna Jaiswal",
  "project": "DevOps Portfolio"
}
```

## Project Structure

```text
.
├── app
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── terraform
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── userdata.sh
│   ├── variables.tf
│   ├── test2-key
│   └── test2-key.pub
├── .gitignore
└── README.md
```

## Prerequisites

- Python 3.11+
- Docker
- Terraform
- AWS account
- AWS credentials configured locally
- Existing EC2 key pair matching `terraform/variables.tf`

## Local Run

### 1. Install Python dependencies

```bash
cd app
pip install -r requirements.txt
```

### 2. Start the app

```bash
uvicorn app:app --host 0.0.0.0 --port 8000
```

### 3. Test locally

- Open `http://127.0.0.1:8000`
- Open `http://127.0.0.1:8000/health`

## Run with Docker

### 1. Build the image

```bash
cd app
docker build -t fastapi-app .
```

### 2. Run the container

```bash
docker run -d --name fastapi-container -p 8000:8000 fastapi-app
```

### 3. Verify

- `http://127.0.0.1:8000`
- `http://127.0.0.1:8000/health`

## Deploy to AWS with Terraform

> Note: Current Terraform config uses a fixed AWS region, AMI ID, and key pair name. Before apply, make sure these values are valid in your account and region.

### 1. Move to Terraform directory

```bash
cd terraform
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the plan

```bash
terraform plan
```

### 4. Apply

```bash
terraform apply
```

### 5. Check outputs

Terraform prints:

- `public_ip`
- `public_dns`
- `private_ip`

After deployment, open the `public_ip` in your browser.

## Important Notes

- The EC2 instance runs the app on port `80` externally and maps it to container port `8000`.
- `userdata.sh` clones this repository from GitHub during provisioning.
- `terraform/main.tf` uses `user_data = file("userdata.sh")`, so the script must stay in the `terraform/` folder.
- `.gitignore` excludes Terraform state, local keys, and Python cache files.

## Terraform Variables

Defaults are defined in [`terraform/variables.tf`](terraform/variables.tf):

- `instance_type` default: `t3.micro`
- `ami_id` default: `ami-0aba19e56f3eaec05`
- `key_pair` default: `test2-key`

If you use your own AWS account, update these values as needed.

## Cleanup

To remove the AWS resources:

```bash
cd terraform
terraform destroy
```

## Troubleshooting

- If the EC2 instance is unreachable, verify the security group allows inbound `80` and `22`.
- If Terraform fails on key pair, ensure the key pair name exists in the selected AWS region.
- If the app does not start on EC2, check the instance console output and Docker logs.
- If `git clone` fails in user data, confirm the repository URL is accessible from the instance.

## Author

Krishna Jaiswal
