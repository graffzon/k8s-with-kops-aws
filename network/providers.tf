provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    region = "eu-central-1"

    encrypt = true
    bucket  = "terraform-remote-state-storage-s3-kzonov"
    key     = "kzonov/network.tfstate"

    dynamodb_table = "terraform-remote-state-lock-kzonov"
  }
}
