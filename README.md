# amorservProject-assessment

# My Web Application

This repository contains the source code for a simple Node.js web application, along with CI/CD pipeline configurations using Jenkins and Terraform.

## Setup Instructions

1. Clone this repository.
2. Ensure you have Node.js, npm, Docker, Jenkins, and Terraform installed on your system.
3. Open a terminal in the project directory and run the following commands:

```bash
# Build and run the Docker container locally
docker build -t josephifekwe97/my-web-app .
docker run -d -p 3000:3000 josephifekwe97/my-web-app

NOTE:  Ensure  to create terraform.dev.tfvars, terraform.staging.tfvars, terraform.prod.tfvars   for each respective  environment be deployed


