# Damolak Infrastructure — Production-Ready DevOps Project

## 🚀 Overview

This project demonstrates a complete end-to-end cloud deployment using Terraform, Docker, AWS ECS, and CI/CD automation.

The goal was to design a **practical, production-inspired infrastructure** while keeping deployment simple, cost-aware, and easy to reproduce.

---

## 🧠 Key Design Philosophy

* Build **real production architecture**, not just theory
* Keep it **modular and reproducible**
* Avoid over-engineering while still showing **depth of understanding**
* Separate critical components (like EIP) to prevent accidental loss
* Use **automation everywhere (CI/CD)**

---

## 🏗️ Architecture

```text
User → ALB → ECS (Fargate) → App
                ↓
           CloudWatch
                ↓
               SNS
           ↙        ↘
        Email      Slack
```

---

## 🔧 Infrastructure Components

### 1. Networking (Terraform Module)

* Custom VPC
* Public Subnets → ALB + NAT Gateway
* Private Subnets → ECS services
* Internet Gateway for inbound traffic
* NAT Gateway for outbound traffic

### 🔐 Persistent EIP Strategy

A **separate Terraform stack** was used to manage Elastic IP:

* Prevents accidental deletion during `terraform destroy`
* Enables safe whitelisting for external services
* Demonstrates production-level lifecycle separation

---

### 2. Compute (ECS Fargate)

* Containerized Node.js application
* Runs inside private subnets
* Connected to ALB target group
* No direct public exposure

---

### 3. Load Balancer (ALB)

* Public entry point
* Routes traffic to ECS service
* Monitored via CloudWatch metrics

---

### 4. Container Registry (ECR)

* Stores Docker images
* Images tagged using commit SHA
* Enables versioned deployments

---

## 🔄 CI/CD Pipeline (GitHub Actions)

Fully automated deployment pipeline:

1. Push to `main`
2. Build Docker image (amd64)
3. Push image to ECR
4. Update ECS task definition
5. Deploy to ECS service

### Key Decision

Instead of dynamic registry resolution, a **fully qualified ECR URI** is used:

```text
<account>.dkr.ecr.<region>.amazonaws.com/repo:commit-sha
```

This avoids pipeline failures and ensures consistency.

---

## 📡 Monitoring & Alerting

### CloudWatch

* Monitors ALB 5xx errors
* Triggers alerts when threshold exceeded

---

### SNS Alerting Strategy

Two alert channels were designed:

#### 🔴 Critical Alerts

* Sent to:

  * Email
  * Slack (via Lambda)

#### 🟡 General Alerts

* Sent to:

  * Email only

---

### Slack Integration

* Implemented using AWS Lambda + Slack Webhook
* Triggered by SNS topic
* Controlled via Terraform variable:

```hcl
enable_slack = true
```

This allows:

* Easy enable/disable without code changes
* Environment-based alert control

---

## 🔐 Security

* IAM roles for ECS and Lambda
* Security groups separating ALB and ECS
* No direct access to private services
* Secrets handled via AWS Secrets Manager

---

## 📦 Terraform Design

* Fully modular structure:

  * network
  * compute
  * security
  * registry
  * monitoring
* Remote state stored in S3
* State locking using DynamoDB

---

## ⚠️ Cost Optimization Strategy

* Infrastructure destroyed after validation
* Design ensures reproducibility via Terraform
* Monitoring and EIP stack separated to avoid accidental costs

---

## 🧪 How to Run

```bash
terraform init
terraform plan -var-file=environments/dev/terraform.tfvars
terraform apply -var-file=environments/dev/terraform.tfvars
```

---

## 🧹 Cleanup

```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

---

## 📌 Future Improvements

* Add WAF for enhanced security
* Multi-environment pipeline (dev → staging → prod)
* Centralized logging (OpenSearch / ELK)
* Autoscaling tuning based on traffic

---

## ✅ Final Result

This project demonstrates:

* Infrastructure as Code (Terraform)
* Containerized deployment (Docker + ECS)
* Automated CI/CD (GitHub Actions)
* Production-style networking (VPC, NAT, ALB)
* Real-time monitoring and alerting (CloudWatch + SNS + Slack)

---

## 🧠 Key Takeaway

This was built to reflect **how real systems are designed**, not just how tools work.

It balances:

* Simplicity
* Reliability
* Production awareness
* Automation
