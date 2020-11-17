resource "aws_batch_compute_environment" "compute-environment" {
  count                    = var.create_compute_environment ? 1 : 0
  compute_environment_name = var.ce_name
  service_role             = var.batch_service_role_arn
  type                     = var.ce_type

  compute_resources {
    instance_role = var.batch_instance_profile_arn
   
    instance_type = var.instance_type
    max_vcpus     = var.max_vcpus
    min_vcpus     = var.min_vcpus
    desired_vcpus = var.desired_vcpus
    bid_percentage = var.bid_percentage
    allocation_strategy = var.ce_allocation_strategy
    security_group_ids = var.security_groups
    subnets = var.subnet_ids
    type    = "SPOT"
    spot_iam_fleet_role = var.spot_iam_fleet_role_arn
  }

  // To prevent a race condition during environment deletion, make sure to set depends_on to the related
  // aws_iam_role_policy_attachment; otherwise, the policy may be destroyed too soon and the compute environment
  // will then get stuck in the DELETING.
  // ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment
  //depends_on = [aws_iam_role_policy_attachment.aws_batch_service_role]

  tags = merge({Name = var.batch_name},var.tags)

  lifecycle {
    ignore_changes = [
       compute_resources.0.desired_vcpus
    ]
   }
}

resource "aws_batch_job_queue" "job_queue" {
  name                 = var.batch_job_queue_name
  state                = var.batch_job_queue_state
  priority             = var.batch_job_queue_priority
  compute_environments = [try(aws_batch_compute_environment.compute-environment.0.arn,var.compute_environment_arn)]
  tags                 = merge({Name = var.batch_name},var.tags)
}

resource "aws_batch_job_definition" "job-definition" {
  name                 = var.batch_job_definition_name
  type                 = "container"
  container_properties = var.ecs_container_properties
  tags                 = merge({Name = var.batch_name},var.tags)
}
