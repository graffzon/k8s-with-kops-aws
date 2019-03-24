resource "aws_network_interface" "master" {
  subnet_id       = "${data.terraform_remote_state.network.private_2_subnet_id}"
  security_groups = ["${aws_security_group.private.id}"]
}
