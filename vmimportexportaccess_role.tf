# ------------------------------------------------------------------------------
# Create the IAM role that has sufficient permissions to manage VM
# Import/Export tasks in the Images account using the AWS CLI.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "vmimportexportaccess" {
  provider = aws.images

  assume_role_policy = data.aws_iam_policy_document.vmimportexportaccess_assume_role.json
  description        = var.vmimportexportaccess_role_description
  name               = var.vmimportexportaccess_role_name
}

resource "aws_iam_role_policy_attachment" "vmimportexportaccess" {
  provider = aws.images

  policy_arn = aws_iam_policy.vmimportexportaccess.arn
  role       = aws_iam_role.vmimportexportaccess.name
}
