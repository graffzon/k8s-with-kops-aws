output "ecr_arn" {
  value = "${aws_ecr_repository.docker-images.arn}"
}
