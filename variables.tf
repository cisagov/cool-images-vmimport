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

variable "read_terraform_state_role_name" {
  type        = string
  description = "The name to associate with the IAM role and attached policy that allows read-only access to the cool-images-vmimport state in the S3 bucket where Terraform state is stored."
  default     = "ReadImagesVMImportTerraformState"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

variable "vmimport_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows the permissions necessary for the vmimport service role to allow VM import/export functionality."
  default     = "Allows permissions necessary for the AWS VM Import/Export feature to function using the specified resources."
}

variable "vmimport_policy_name" {
  type        = string
  description = "The name to associate with the IAM policy that allows the permissions necessary for the vmimport service role to allow VM import/export functionality."
  default     = "Images-ServiceRoleAccess-vmimport"
}

# We do not have a var.vmimport_role_name because we use the statically defined
# local.vmimport_role_name instead. This is because the role name must be
# a specific value as described in
# https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role
variable "vmimport_role_description" {
  type        = string
  description = "The description to associate with the vmimport service role."
  default     = "The service role that is required by the AWS VM Import/Export feature to function in this account."
}

variable "vmimportexportaccess_role_description" {
  type        = string
  description = "The description to associate with the IAM role and attached policy that allows the permissions necessary to use the VM Import/Export feature with the AWS CLI."
  default     = "Allows permissions necessary to use the AWS VM Import/Export feature with the AWS CLI."
}

variable "vmimportexportaccess_role_name" {
  type        = string
  description = "The name to associate with the IAM role and attached policy that allows the permissions necessary to use the VM Import/Export feature with the AWS CLI."
  default     = "Images-VMImportExportAccess"
}
