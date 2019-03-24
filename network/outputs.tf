output "private_2_subnet_id" {
  value = "${aws_subnet.kzonov-private-2.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.kzonov-public.id}"
}

output "vpc_id" {
  value = "${aws_vpc.kzonov.id}"
}
