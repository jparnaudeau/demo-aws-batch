output "batch_security_group_id" {
  description = "The Security Group Id in which each Batch is associated."
  value       = aws_security_group.sg-batch.id
}

output "batch_instance_profile_arn" {
  description = "The Instance Profile ARN associated to each Batchs."
  value       = aws_iam_instance_profile.batch_instance_profile.arn
}

output "batch_service_role_arn" {
  description = "The Batch Service Role ARN for execution Batchs."
  value       = aws_iam_role.batch_service_role.arn
}

output "batch_spot_iam_fleet_role_arn" {
  description = "The Dedicated Spot Role ARN use for interact with spot fleet."
  value       = aws_iam_role.AmazonEC2SpotFleetRole.arn
}

output "batch_compute_environment_name" {
  description = "The Compute Environment name used to execute batchs."
  value       = aws_batch_compute_environment.compute-environment.compute_environment_name
}

output "batch_compute_environment_state" {
  description = "The Compute Environment state used to execute batchs"
  value       = aws_batch_compute_environment.compute-environment.state
}
