resource "aws_internet_gateway" "kzonov-public" {
  vpc_id = "${aws_vpc.kzonov.id}"

  tags {
    Owner = "kzonov"
  }
}

resource "aws_route_table" "kzonov-public" {
  vpc_id = "${aws_vpc.kzonov.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kzonov-public.id}"
  }

  tags {
    Owner = "kzonov"
  }
}

resource "aws_route_table_association" "kzonov" {
  subnet_id      = "${aws_subnet.kzonov-public.id}"
  route_table_id = "${aws_route_table.kzonov-public.id}"
}
