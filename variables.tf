# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

variable "vmimport_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows the permissions necessary for the vmimport service role to allow VM import/export functionality."
  default     = "Allows access requirements necessary for the AWS VM Import/Export feature to function using the specified resources."
}

variable "vmimport_policy_name" {
  type        = string
  description = "The name to associate with the IAM policy that allows the permissions necessary for the vmimport service role to allow VM import/export functionality."
  default     = "Images-ServiceRoleAccess-vmimport"
}
