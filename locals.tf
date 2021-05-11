# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which Terraform is
# authorized.  This is used to calculate the session names for assumed roles.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# ------------------------------------------------------------------------------
# Retrieve the caller identity for the "users" provider in order to
# get the account ID associated with the Users account.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "users" {
  provider = aws.users
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Extract the user name of the current caller for use
  # as assume role session names.
  caller_user_name = split("/", data.aws_caller_identity.current.arn)[1]

  # Hardcoded value to provide the name for the vmimport service role.
  vmimport_role_name = "vmimport"

  # The account ID for the Users account
  users_account_id = data.aws_caller_identity.users.account_id
}
