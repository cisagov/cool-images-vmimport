# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the AWS VM Import/Export feature to
# assume the vmimport service role.
# ------------------------------------------------------------------------------

# This policy document is derived from the one described in
# https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role
data "aws_iam_policy_document" "vmimport_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "vmie.amazonaws.com",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:Externalid"

      values = [
        "vmimport"
      ]
    }
  }
}
