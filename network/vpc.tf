resource "aws_vpc" "kzonov" {
  cidr_block = "10.24.0.0/16"

  tags = {
    Owner = "kzonov"
  }
}

resource "aws_subnet" "kzonov-public" {
  vpc_id            = "${aws_vpc.kzonov.id}"
  cidr_block        = "10.24.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Owner = "kzonov"
  }
}

resource "aws_subnet" "kzonov-private-2" {
  vpc_id            = "${aws_vpc.kzonov.id}"
  cidr_block        = "10.24.2.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Owner = "kzonov"
  }
}

resource "aws_subnet" "kzonov-private-3" {
  vpc_id            = "${aws_vpc.kzonov.id}"
  cidr_block        = "10.24.3.0/24"
  availability_zone = "eu-west-1b"

  tags {
    Owner = "kzonov"
  }
}
