provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "terraform-remote-state-storage-s3-kzonov"
    region  = "eu-central-1"
    key     = "kzonov/k8s.tfstate"

    dynamodb_table = "terraform-remote-state-lock-kzonov"
  }
}
