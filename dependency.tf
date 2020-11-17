#######################################
# retrieve region
#######################################
data "aws_region" "current" {}



######################################
# Retrieve the secret for RDS Database
######################################
# data "aws_secretsmanager_secret" "rds_password" {
#   name = "RDS_PASSWORD"
# }
