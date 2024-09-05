# 🌩️ Cloud Resume Challenge - Infrastructure Repository 🌩️

Welcome to the infrastructure repository of my Cloud Resume Challenge! This project is part of the **Cloud Resume Challenge**, where I build and deploy a resume website using cloud services and infrastructure as code (IaC). This repository is dedicated to defining and deploying all the necessary AWS services using **Terraform**.

## 🚀 Project Overview

In this repository, the infrastructure for the **Cloud Resume Challenge** is defined and managed using Terraform. The infrastructure includes services like **S3**, **CloudFront**, **Route 53**, **Lambda**, **API Gateway**, and **DynamoDB**.

## 🛠️ AWS Services Deployed

The following AWS services are provisioned as part of this project:

1. **🌐 Hosting and Distribution**
   - **Amazon S3**: To host the static frontend website.
   - **Amazon CloudFront**: To distribute the content globally with low latency and HTTPS support.

2. **🔗 DNS Management**
   - **Amazon Route 53**: To manage the custom domain and point it to the CloudFront distribution for seamless access.

3. **💾 Database**
   - **Amazon DynamoDB**: A NoSQL database to store visitor counts for the resume website.

4. **⚙️ Serverless Functions**
   - **AWS Lambda**: Lambda functions are deployed for multiple purposes.

5. **🔌 API Management**
   - **Amazon API Gateway**: To expose the Lambda function as an HTTP API that can be accessed by the frontend.

## 🔄 Infrastructure as Code (IaC) with Terraform

This entire infrastructure is defined using **Terraform**. Terraform allows for the declarative management of cloud resources, ensuring that the same infrastructure can be deployed consistently across multiple environments.

