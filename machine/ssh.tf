resource "aws_key_pair" "kzonov" {
  key_name   = "kzonov"
  public_key = "ssh-rsa mysshkey graffzon@gmail.com"
}
