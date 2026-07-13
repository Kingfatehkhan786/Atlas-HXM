output "db_endpoint" {
  description = "Payroll database endpoint"
  value       = aws_db_instance.payroll.endpoint
}

output "db_password" {
  description = "Payroll database password"
  value       = aws_db_instance.payroll.password
  sensitive   = true
}

output "security_group_id" {
  description = "Security group ID for payroll service"
  value       = aws_security_group.payroll_app.id
}

output "iam_role_arn" {
  description = "IAM role ARN for payroll service"
  value       = aws_iam_role.payroll_service.arn
}
