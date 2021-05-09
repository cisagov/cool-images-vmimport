# ------------------------------------------------------------------------------
# Create the IAM policies that give the vmimport service role sufficient
# permissions to function in the Images (Production) and Images (Staging)
# accounts.
# ------------------------------------------------------------------------------

# These policy documents are based on the permissions required for the vmimport
# service role as described in
# https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role
data "aws_iam_policy_document" "vmimport_production" {
  # Buckets to use for image import (VM -> AMI)
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_production.arn,
      "${data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_production.arn}/*"
    ]
  }

  # Buckets to use for image export (AMI -> VM)
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetBucketAcl",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_production.arn,
      "${data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_production.arn}/*"
    ]
  }

  # AMI creation
  statement {
    actions = [
      "ec2:ModifySnapshotAttribute",
      "ec2:CopySnapshot",
      "ec2:RegisterImage",
      "ec2:Describe*",
    ]
    resources = [
      "*",
    ]
  }

  # Import resources encrypted with an AWS KMS key
  statement {
    actions = [
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]
    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "vmimport_staging" {
  # Buckets to use for image import (VM -> AMI)
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_staging.arn,
      "${data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_staging.arn}/*"
    ]
  }

  # Buckets to use for image export (AMI -> VM)
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetBucketAcl",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_staging.arn,
      "${data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket_staging.arn}/*"
    ]
  }

  # AMI creation
  statement {
    actions = [
      "ec2:ModifySnapshotAttribute",
      "ec2:CopySnapshot",
      "ec2:RegisterImage",
      "ec2:Describe*",
    ]
    resources = [
      "*",
    ]
  }

  # Import resources encrypted with an AWS KMS key
  statement {
    actions = [
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "vmimport_production" {
  provider = aws.images_production

  description = var.vmimport_policy_description
  name        = var.vmimport_policy_name
  policy      = data.aws_iam_policy_document.vmimport_production.json
}

resource "aws_iam_policy" "vmimport_staging" {
  provider = aws.images_staging

  description = var.vmimport_policy_description
  name        = var.vmimport_policy_name
  policy      = data.aws_iam_policy_document.vmimport_staging.json
}
