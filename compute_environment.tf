resource "aws_batch_compute_environment" "compute-environment" {
  compute_environment_name = local.ce_name
  service_role             = aws_iam_role.batch_service_role.arn
  type                     = "MANAGED"

  compute_resources {
    instance_role       = aws_iam_instance_profile.batch_instance_profile.arn
    spot_iam_fleet_role = aws_iam_role.AmazonEC2SpotFleetRole.arn
   
    instance_type       = var.instance_type
    max_vcpus           = var.max_vcpus
    min_vcpus           = var.min_vcpus
    desired_vcpus       = var.desired_vcpus
    bid_percentage      = var.bid_percentage
    allocation_strategy = var.allocation_strategy
    security_group_ids  = [aws_security_group.sg-batch.id]
    subnets             = var.subnet_ids
    type                = "SPOT"
  }

  // To prevent a race condition during environment deletion, make sure to set depends_on to the related
  // aws_iam_role_policy_attachment; otherwise, the policy may be destroyed too soon and the compute environment
  // will then get stuck in the DELETING.
  // ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment
  //depends_on = [aws_iam_role_policy_attachment.aws_batch_service_role]

  tags = merge({Name = local.ce_name},local.common_tags)

  lifecycle {
    ignore_changes = [
       compute_resources.0.desired_vcpus
    ]
   }
}

variable "instance_type" {
   type        = list(string)
   description = "batch instance type"
   default     = ["m4"]
 }

variable "max_vcpus" {
  type        = number
  description = "batch max vcpus"
  default     = 1
}

variable "min_vcpus" {
  type        = number
  description = "batch min_vcpus"
  default     = 0
}

variable "desired_vcpus" {
  type        = number
  description = "batch desired vcpus"
  default     = 0
}

variable "job_queue_priority" {
  type        = number
  description = "Batch Job Queue Priority"
  default     = 1
}

variable "bid_percentage" {
  type        = number
  description = "Integer of minimum percentage that a Spot Instance price must be when compared with the On-Demand price for that instance type before instances are launched. For example, if your bid percentage is 20% (20), then the Spot price must be below 20% of the current On-Demand price for that EC2 instance. This parameter is required for SPOT compute environments."
  default     = 100
}

variable "allocation_strategy" {
  type        = string
  description = "the allocation strategy to affect to the ComputeEnvironment"
  default     = "SPOT_CAPACITY_OPTIMIZED"
}
