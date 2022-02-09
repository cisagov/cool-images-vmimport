output "read_terraform_state" {
  value       = module.read_terraform_state
  description = "The IAM policies and role that allow read-only access to the cool-images-vmimport state in the Terraform state bucket."
}

output "vmimport_role" {
  value       = aws_iam_role.vmimport.arn
  description = "The ARN for the vmimport service role in the Images account."
}

output "vmimportexportaccess_role" {
  value       = aws_iam_role.vmimportexportaccess
  description = "The IAM role that can be assumed to manage VM Import/Export tasks in the Images account."
}
