locals {
  "cluster_manager_policies" = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
  ]
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "cluster-manager" {
  role       = "${aws_iam_role.cluster-manager.name}"
  policy_arn = "${local.cluster_manager_policies[count.index]}"

  count = "${length(local.cluster_manager_policies)}"
}

resource "aws_iam_instance_profile" "cluster-manager" {
  name = "cluster-manager"
  role = "${aws_iam_role.cluster-manager.name}"
}

resource "aws_iam_role" "cluster-manager" {
  name               = "cluster-manager"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}
