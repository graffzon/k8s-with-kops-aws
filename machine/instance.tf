resource "aws_instance" "bastion" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "kzonov"

  network_interface {
    network_interface_id = "${aws_network_interface.bastion.id}"
    device_index         = 0
  }

  tags {
    Owner = "kzonov"
  }
}
