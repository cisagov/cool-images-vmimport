output "vmimport_role_production" {
  value       = aws_iam_role.vmimport_production.arn
  description = "The ARN for the vmimport service role in the Images (Production) account."
}

output "vmimport_role_staging" {
  value       = aws_iam_role.vmimport_staging.arn
  description = "The ARN for the vmimport service role in the Images (Staging) account."
}
