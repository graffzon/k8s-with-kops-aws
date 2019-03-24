provider "aws" {
  region  = "eu-west-1"
  profile = "sandbox"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "temp-terraform-remote-state-storage-s3-kzonov"
    region  = "eu-west-1"
    profile = "sandbox"
    key     = "kzonov/machine.tfstate"

    dynamodb_table = "temp-terraform-remote-state-lock-kzonov"
  }
}
