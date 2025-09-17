import {
  to = aws_iam_openid_connect_provider.terraform-cloud
  id = "arn:aws:iam::181179258370:oidc-provider/app.terraform.io"
}

import {
  to = aws_iam_role.terraform_cloud_admin
  id = "terraform-cloud-automation-admin"
}

data "tls_certificate" "terraform-cloud" {
  url = "https://${var.terraform-cloud-hostname}"
}

resource "aws_iam_openid_connect_provider" "terraform-cloud" {
  url             = data.tls_certificate.terraform-cloud.url
  client_id_list  = [var.terraform-audience]
  thumbprint_list = [data.tls_certificate.terraform-cloud.certificates[0].sha1_fingerprint]

  tags = {
    "Name" = "Terraform Cloud"
  }
}

data "aws_iam_policy_document" "terraform_cloud_admin_assume_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.terraform-cloud.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${var.terraform-cloud-hostname}:aud"
      values   = [var.terraform-audience]
    }
    condition {
      test     = "StringLike"
      variable = "${var.terraform-cloud-hostname}:sub"
      values   = ["organization:AitorConS:project:terraform-oidc:workspace:terraform-cli:run_phase:*"]
    }

  }
}

resource "aws_iam_role" "terraform_cloud_admin" {
  name               = "terraform-cloud-automation-admin"
  assume_role_policy = data.aws_iam_policy_document.terraform_cloud_admin_assume_policy.json
}

data "aws_iam_policy" "admin_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


import {
  to = aws_iam_role_policy_attachment.terraform-cloud-admin
  id = "${aws_iam_role.terraform_cloud_admin.name}/${data.aws_iam_policy.admin_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "terraform-cloud-admin" {
  role       = aws_iam_role.terraform_cloud_admin.name
  policy_arn = data.aws_iam_policy.admin_policy.arn
}