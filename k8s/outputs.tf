output "ecr_arn" {
  value = "${aws_ecr_repository.docker-images.arn}"
}

output "ecr_url" {
  value = "${aws_ecr_repository.docker-images.repository_url}"
}
