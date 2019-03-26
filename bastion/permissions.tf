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

resource "aws_iam_policy" "ecr-read" {
  name = "ecr-read"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:ListImages"
      ],
      "Effect": "Allow",
      "Resource": "${data.terraform_remote_state.k8s.ecr_arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecr-read" {
  role       = "${aws_iam_role.bastion-extended.name}"
  policy_arn = "${aws_iam_policy.ecr-read.arn}"
}

resource "aws_iam_role_policy_attachment" "bastion-extended" {
  role       = "${aws_iam_role.bastion-extended.name}"
  policy_arn = "${local.cluster_manager_policies[count.index]}"

  count = "${length(local.cluster_manager_policies)}"
}

resource "aws_iam_instance_profile" "bastion-extended" {
  name = "bastion-extended"
  role = "${aws_iam_role.bastion-extended.name}"
}

resource "aws_iam_role" "bastion-extended" {
  name               = "bastion-extended"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}
