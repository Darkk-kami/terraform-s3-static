terraform {
  required_version = ">= 1.10.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.82.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
  }

  backend "s3" {
    bucket = "yourbackendbucket"
    key    = "terraform/s3-website"
    region = "us-east-1"
  }
}


provider "aws" {
  region = var.region
}

provider "random" {
}