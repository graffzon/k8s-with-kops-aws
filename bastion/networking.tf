resource "aws_network_interface" "bastion" {
  subnet_id       = "${data.terraform_remote_state.network.public_subnet_id}"
  security_groups = ["${aws_security_group.with-only-ssh-allowed.id}"]
}

resource "aws_eip" "external-address" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}
