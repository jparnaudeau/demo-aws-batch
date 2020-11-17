module "batch-example" {
  source          = "./batch-deployment"
  subnet_ids      = var.subnet_ids
  environment     = var.environment
  security_groups = [aws_security_group.sg-batch.id]

  // workload parameters
  batch_name               = var.batch_name
  
  # cf https://docs.aws.amazon.com/batch/latest/APIReference/API_RegisterJobDefinition.html
  ecs_container_properties = templatefile("job-defintions/functionaltest.json", 
                                              { 
                                                REGION                     = data.aws_region.current.name
                                                ENV                        = var.environment
                                                BATCH_NAME                 = var.batch_name
                                                BATCH_IMAGE                = var.batch_image
                                                BATCH_MEMORY               = var.batch_memory
                                                BATCH_VCPUS                = var.batch_vcpus
                                                JOB_ROLE_ARN               = aws_iam_role.batch_ecs_task_execution_role.arn
                                                EXECUTION_ROLE_ARN         = aws_iam_role.batch_ecs_task_execution_role.arn
                                                #MY_PASSWORD_SECRET_ARN     = data.aws_secretsmanager_secret.rds_password.arn 
                                                BUCKET_NAME                = "mybucket"
                                              }
                                            )

  # 4 roles are needed
  # - Batch Instance Role <-> Batch Instance Profile : mandatory, used for type "EC2". So ignore for our case (type = SPOT) 
  # - Batch ecs execution Role : use the assumeRole for ecs-tasks.amazonaws.com. used in job definition : attach additional policies on it
  # - Batch Service Role : This is an IAM role that is used by AWS Batch to manage resources on your behalf.
  # - Spot IAM Fleet role

  batch_instance_profile_arn   = aws_iam_instance_profile.batch_instance_profile.arn
  batch_service_role_arn       = aws_iam_role.batch_service_role.arn
  spot_iam_fleet_role_arn      = aws_iam_role.AmazonEC2SpotFleetRole.arn


  // Compute Environment configuration.
  create_compute_environment = false
  compute_environment_arn    = aws_batch_compute_environment.compute-environment.arn

  // Jobs with lowest priority are scheduled fist.
  batch_job_queue_name       = "queue-${var.environment}-${var.application}-${var.batch_name}"
  batch_job_definition_name  = "jdef-${var.environment}-${var.application}-${var.batch_name}"
  batch_job_queue_priority   = var.batch_job_queue_priority

  // put tags
  tags = local.common_tags
}
