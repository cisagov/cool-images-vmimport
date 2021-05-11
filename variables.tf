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

variable "vmimport_role_description" {
  type        = string
  description = "The description to associate with the vmimport service role."
  default     = "The service role that is required by the AWS VM Import/Export feature to function in this account."
}

variable "vmimportexportaccess_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows the permissions necessary to use the VM Import/Export feature with the AWS CLI."
  default     = "Allows access requirements necessary to use the AWS VM Import/Export feature with the AWS CLI."
}

variable "vmimportexportaccess_policy_name" {
  type        = string
  description = "The name to associate with the IAM policy that allows the permissions necessary to use the VM Import/Export feature with the AWS CLI."
  default     = "Images-VMImportExportAccess"
}
