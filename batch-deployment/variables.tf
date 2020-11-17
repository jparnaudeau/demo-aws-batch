#############################
# Common Variables
#############################
variable "subnet_ids" {
  type = list(string)  
  description = "subnet id's for batch"
}

variable "environment" {
  type        = string
  description = "The environment on which we want create resources"
}

variable "security_groups" {
  description = "Security groups to be used by the Compute Environment."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "a map of tags to put on AWS Batch Resource"
  type        = map(string)
  default     = {}
}

#############################
# Compute Environment - Variables
#############################
variable "create_compute_environment" {
  type        = bool
  description = "Enable/Disable the creation of a dedicated compute environment"
  default     = false
}

variable "compute_environment_arn" {
  type        = string
  description = "The ARN of shared compute environment"
  default     = ""
}

variable "ce_name" {
  description = "Given name for the Compute Environment."
  type        = string
  default     = "main"
}

variable "ce_type" {
  description = "Compute Environment type."
  type        = string
  default     = "MANAGED"
}

// Valid items are BEST_FIT_PROGRESSIVE, SPOT_CAPACITY_OPTIMIZED or BEST_FIT.
variable "ce_allocation_strategy" {
  description = "The allocation strategy to use for the compute resource."
  default     = "BEST_FIT"
}

// The instance types that may be launched. You can specify instance families to launch any instance type within
// those families (for example, c5, c5n, or p3), or you can specify specific sizes within a family (such as c5.8xlarge).
// Note that metal instance types are not in the instance families (for example c5 does not include c5.metal.)
// You can also choose optimal to pick instance types (from the C, M, and R instance families) on the fly that match the
// demand of your job queues
variable "instance_type" {
  description = "The instance_type for compute environment to use."
  type        = list(string)
  default     = ["optimal"]
}

// Map or json file with defined ec2_container_properties.
variable "ecs_container_properties" {
  description = "A valid container properties provided as a single valid JSON document."
}


variable "max_vcpus" {
  description = "Maximum allowed VCPUs allocated to instances."
  type        = number
  default     = 2
}

variable "min_vcpus" {
  description = "Minimum number of VCPUs allocated to instances."
  type        = number
  default     = 0
}

variable "desired_vcpus" {
  description = "Desired number of VCPUs allocated to instances."
  type        = number
  default     = 1
}

variable "bid_percentage" {
  description = "Integer of minimum percentage that a Spot Instance price must be when compared with the On-Demand price for that instance type before instances are launched. For example, if your bid percentage is 20% (20), then the Spot price must be below 20% of the current On-Demand price for that EC2 instance."
  type        = number
  default     = 100
}

variable "batch_name" {
  description = "Batch name. Used in naming convention for iam resources"
  type        = string
  default     = "batch"
}

variable "batch_job_definition_name" {
  description = "Batch Job definition name."
  type        = string
  default     = "batch-job-definition"
}

variable "batch_job_queue_name" {
  description = "Batch Job queue name."
  type        = string
  default     = "batch-job-queue"
}

// Must be either ENABLED or DISABLED.
variable "batch_job_queue_state" {
  description = "State of the created Job Queue."
  type        = string
  default     = "ENABLED"
}

// The priority of the job queue. Job queues with a higher priority are evaluated first when associated
// with the same compute environment.
variable "batch_job_queue_priority" {
  description = "Priority of the created Job Queue."
  type        = string
  default     = "100"
}

#############################
# Batch IAM Roles - Variables
#############################
variable "batch_instance_profile_arn" {
  type        = string
  description = "Instance Profile ARN"
}

variable "spot_iam_fleet_role_arn" {
  type        = string
  description = "The Role ARN for spot fleet"
}

# variable "batch_ecs_execution_role_arn" {
#   type        = string
#   description = "The execution Role ARN for ecs-tasks"
# }

#This is an IAM role that is used by AWS Batch to manage resources on your behalf.
variable "batch_service_role_arn" {
  type        = string
  description = "The Batch Service Role"
}
