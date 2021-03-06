# ------------------------------------------------------------------------------
# Create the IAM roles that have sufficient permissions to manage VM
# Import/Export tasks in the Images (Production) and Images (Staging) accounts
# using the AWS CLI.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "vmimportexportaccess_production" {
  provider = aws.images_production

  assume_role_policy = data.aws_iam_policy_document.vmimportexportaccess_assume_role.json
  description        = var.vmimportexportaccess_role_description
  name               = var.vmimportexportaccess_role_name
  tags               = { "Workspace" = "production" }
}

resource "aws_iam_role_policy_attachment" "vmimportexportaccess_production" {
  provider = aws.images_production

  policy_arn = aws_iam_policy.vmimportexportaccess_production.arn
  role       = aws_iam_role.vmimportexportaccess_production.name
}

resource "aws_iam_role" "vmimportexportaccess_staging" {
  provider = aws.images_staging

  assume_role_policy = data.aws_iam_policy_document.vmimportexportaccess_assume_role.json
  description        = var.vmimportexportaccess_role_description
  name               = var.vmimportexportaccess_role_name
  tags               = { "Workspace" = "staging" }
}

resource "aws_iam_role_policy_attachment" "vmimportexportaccess_staging" {
  provider = aws.images_staging

  policy_arn = aws_iam_policy.vmimportexportaccess_staging.arn
  role       = aws_iam_role.vmimportexportaccess_staging.name
}
