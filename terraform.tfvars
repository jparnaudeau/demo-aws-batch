# VPC & Network variables
vpc_id     = "12345678"
subnet_ids = ["ae56b23","df56a89"]

# Common tags & naming convention
environment = "test"
application = "myapp"
owner       = "jparnaudeau"

####################################
## GLOBAL CONFIGURATION FOR BATCH
####################################
batch_name = "functionaltest"

# The image to use
batch_image = "busybox"

# sizing of the container
batch_memory = 4096
batch_vcpus  = 8

# priority in the job queue associated
batch_job_queue_priority = 1
