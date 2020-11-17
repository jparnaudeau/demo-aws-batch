######################################################################
# ECS Task Execution Role
######################################################################
resource "aws_iam_role" "batch_ecs_task_execution_role" {
  name = "role-${var.environment}-${var.application}-batch-ecs-task-execution-role"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": ["ecs-tasks.amazonaws.com","ec2.amazonaws.com"]
        }
    }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "batch_ecs_task_execution_role" {
  role       = aws_iam_role.batch_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs-tasks-exec-batch-additional-policy-attachment" {
  role       = aws_iam_role.batch_ecs_task_execution_role.name
  policy_arn = aws_iam_policy.batch-additional-policy.arn
}



######################################################################
# BATCH - INSTANCE ROLE
######################################################################
data "aws_iam_policy_document" "instance-assume-role-ec2-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#ROLE
resource "aws_iam_role" "batch_instance_role" {
    name               = "role-${var.environment}-${var.application}-batch-instance"
    assume_role_policy = data.aws_iam_policy_document.instance-assume-role-ec2-policy.json
    
    tags = local.common_tags
}

#INSTANCE PROFILE
resource "aws_iam_instance_profile" "batch_instance_profile" {
  name       = "role-${var.environment}-${var.application}-batch-instance-profile"
  role       = aws_iam_role.batch_instance_role.name
}

# # Attach AWS Policy AmazonEC2ContainerServiceforEC2Role
resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.batch_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

#################################
# Permissions for Batch Workload
# - readSecrets policy + kms ReadPolicy
# - Permissions to putObject in s3 bucket
# - Permissions to mount EFS volume
#################################
resource "aws_iam_policy" "batch-additional-policy" {
  name = "policy-${var.environment}-${var.application}-batch-additional-permissions"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowBucketOperations",
      "Effect": "Allow",
      "Action": [
        "s3:Put*",
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": [
        "arn:aws:s3:::mybucket/*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:ListBucket"
        ],
        "Resource": [
            "arn:aws:s3:::mybucket"
        ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListAllMyBuckets"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowEFSMount",
      "Action": [
        "elasticfilesystem:ClientMount",
        "elasticfilesystem:ClientWrite",
        "elasticfilesystem:CreateMountTarget"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}


######################################################################
# Batch Service Role
######################################################################
data "aws_iam_policy_document" "instance-assume-role-batch-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "batch_service_role" {
    name               = "role-${var.environment}-${var.application}-batch-service"
    assume_role_policy = data.aws_iam_policy_document.instance-assume-role-batch-policy.json
    
    tags = local.common_tags
}

# Attach AWS Policy AWSBatchServiceRole
resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

