# ------------------------------------------------------------------------------
# Create the IAM policy that gives the vmimport service role sufficient
# permissions to function in the Images account.
# ------------------------------------------------------------------------------

# These policy documents are based on the permissions required for the vmimport
# service role as described in
# https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role
data "aws_iam_policy_document" "vmimport" {
  # Buckets to use for image import (VM -> AMI)
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket.arn,
      "${data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket.arn}/*"
    ]
  }

  # Buckets to use for image export (AMI -> VM)
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket.arn,
      "${data.terraform_remote_state.assessment_images.outputs.assessment_images_bucket.arn}/*"
    ]
  }

  # AMI creation
  statement {
    actions = [
      "ec2:CopySnapshot",
      "ec2:Describe*",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
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

resource "aws_iam_policy" "vmimport" {
  provider = aws.images

  description = var.vmimport_policy_description
  name        = var.vmimport_policy_name
  policy      = data.aws_iam_policy_document.vmimport.json
}
