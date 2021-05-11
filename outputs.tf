output "vmimport_role_production" {
  value       = aws_iam_role.vmimport_production.arn
  description = "The ARN for the vmimport service role in the Images (Production) account."
}

output "vmimport_role_staging" {
  value       = aws_iam_role.vmimport_staging.arn
  description = "The ARN for the vmimport service role in the Images (Staging) account."
}

output "vmimportexportaccess_role_production" {
  value       = aws_iam_role.vmimportexportaccess_production
  description = "The IAM role that can be assumed to manage VM Import/Export tasks in the Images (Production) account."
}

output "vmimportexportaccess_role_staging" {
  value       = aws_iam_role.vmimportexportaccess_staging
  description = "The IAM role that can be assumed to manage VM Import/Export tasks in the Images (Staging) account."
}
