# ===========================================================
# Tags Variables
# ===========================================================
variable "environment" {
  type        = string
  description = "The environment on which we want create resources"
}

variable "owner" {
  type        = string
  description = "The owner of the environment"
}

variable "application" {
  type        = string
  description = "The name of the application"
  default     = "origenes"
}

# ===========================================================
# Network & KMS Variables
# ===========================================================
variable "subnet_ids" {
  type = list(string)  
  description = "subnet id's for batch"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

# ===========================================================
# AWS Batch Variables
# ===========================================================
variable "compute_environment_name" {
  type        = string
  description = "compute environment"
  default     = "default"
}

###########################
# Define variables dedicated to this batch
###########################
variable "batch_name" {
  type        = string
  description = "Batch geography name"
}

variable "batch_image" {
  type        = string
  description = "batch image"
}

variable "batch_job_queue_priority" {
  type        = number
  description = "Batch Job Queue Priority"
  default     = 1
}

variable "batch_memory" {
  type        = number
  description = "the memory allocated to the container. Can't be greather than memory available from spot instance type"
  default     = 1024
}

variable "batch_vcpus" {
  type        = number
  description = "the number of vcpus allocated to the container. Can't be greather than vcpus available from spot instance type"
  default     = 1
}
