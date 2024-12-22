# Static Website Infrastructure with Terraform

This repository contains Terraform configurations for provisioning the infrastructure needed to host a static website on AWS. The setup includes an S3 bucket for storing website content, CloudFront for secure and fast content delivery, and optional integration with Route 53 for DNS management.

## Project Description

The project focuses on deploying a highly available and cost-effective static website with the following components:

- **S3 Bucket**: Used to store static website files (HTML, CSS, JS, etc.).
- **CloudFront**: Provides a content delivery network (CDN) for fast and secure website access globally.
- **Optional Route 53**: Enables DNS management for custom domain integration.

The design is modular, allowing you to deploy the infrastructure with or without a custom domain.

## Assumptions

- You have a pre-existing domain (optional for Route 53 integration).
- The S3 bucket for website hosting is private, with access restricted to CloudFront.

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Darkk-kami/terraform-s3-static.git
   cd terraform-s3-static
   ```
2. Navigate to the Environment Directory:
    ```bash
    cd env/dev
    ```
3. Configure Variables:
- Update the `terraform.tfvars` file with your specific settings.
  - Set `domain_name` to your custom domain if available.
- Replace the backend configuration with your remote backend otherwise comment out the code