resource "aws_s3_bucket" "state-storage-s3" {
  bucket = "kubernetes-remote-state-storage-s3-kzonov"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}
