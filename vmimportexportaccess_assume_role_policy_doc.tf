# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the Users account to
# assume the VMImportExportAccess role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "vmimportexportaccess_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      identifiers = [
        local.users_account_id,
      ]
    }
  }
}
