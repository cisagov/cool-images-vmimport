# ------------------------------------------------------------------------------
# Create the IAM role that allows full access to the assessment images
# bucket in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "vmimport" {
  provider = aws.images

  assume_role_policy = data.aws_iam_policy_document.vmimport_assume_role.json
  description        = var.vmimport_role_description
  name               = local.vmimport_role_name
}

resource "aws_iam_role_policy_attachment" "vmimport" {
  provider = aws.images

  policy_arn = aws_iam_policy.vmimport.arn
  role       = aws_iam_role.vmimport.name
}
