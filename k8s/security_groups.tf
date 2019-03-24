resource "aws_security_group" "private" {
  name        = "private"
  description = "Doesnt allow any external access"
  vpc_id      = "${data.terraform_remote_state.network.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
