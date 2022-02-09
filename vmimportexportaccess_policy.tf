# ------------------------------------------------------------------------------
# Create the IAM policy that gives sufficient permissions to manage VM
# Import/Export tasks in the Images account using the AWS CLI.
# ------------------------------------------------------------------------------

# This policy document is based on the permissions required to use the VM
# Import/Export feature as described in
# https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#iam-permissions-image
# The CreateBucket and DeleteBucket permissions have been omitted as management
# of the bucket is handled by the cisagov/cool-images-assessment-images project.
data "aws_iam_policy_document" "vmimportexportaccess" {
  statement {
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    resources = [
      data.terraform_remote_state.assessment_images.outputs.imagesassessment_images_bucket.arn,
      "${data.terraform_remote_state.assessment_images.outputs.imagesassessment_images_bucket.arn}/*"
    ]
  }

  statement {
    actions = [
      "ec2:CancelConversionTask",
      "ec2:CancelExportTask",
      "ec2:CancelImportTask",
      "ec2:CreateImage",
      "ec2:CreateInstanceExportTask",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeConversionTasks",
      "ec2:DescribeExportImageTasks",
      "ec2:DescribeExportTasks",
      "ec2:DescribeImages",
      "ec2:DescribeImportImageTasks",
      "ec2:DescribeImportSnapshotTasks",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeSnapshots",
      "ec2:DescribeTags",
      "ec2:ExportImage",
      "ec2:ImportImage",
      "ec2:ImportInstance",
      "ec2:ImportSnapshot",
      "ec2:ImportVolume",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "vmimportexportaccess" {
  provider = aws.images

  description = var.vmimportexportaccess_role_description
  name        = var.vmimportexportaccess_role_name
  policy      = data.aws_iam_policy_document.vmimportexportaccess.json
}
