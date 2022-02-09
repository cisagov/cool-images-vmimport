# ------------------------------------------------------------------------------
# Create the IAM roles that allow full access to the assessment images
# bucket in the Images (Production) account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "vmimport_production" {
  provider = aws.images_production

  assume_role_policy = data.aws_iam_policy_document.vmimport_assume_role.json
  description        = var.vmimport_role_description
  name               = local.vmimport_role_name
  tags               = { "Workspace" = "production" }
}

resource "aws_iam_role_policy_attachment" "vmimport_production" {
  provider = aws.images_production

  policy_arn = aws_iam_policy.vmimport_production.arn
  role       = aws_iam_role.vmimport_production.name
}
