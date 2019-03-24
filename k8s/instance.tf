data "template_file" "user_data" {
  template = "${file("user_data.sh")}"
}

resource "aws_instance" "master" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  user_data = "${data.template_file.user_data.rendered}"

  network_interface {
    network_interface_id = "${aws_network_interface.master.id}"
    device_index         = 0
  }

  tags {
    Owner = "kzonov"
    Name  = "kzonov-temp"
  }
}
