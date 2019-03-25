data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical Ltd., the company behind Ubuntu
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket = "terraform-remote-state-storage-s3-kzonov"
    region = "eu-central-1"
    key    = "kzonov/network.tfstate"
  }
}
