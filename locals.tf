locals {
  common_tags = {
    "environment" = var.environment
    "application" = var.application
    "owner"       = var.owner
  }

  # Compute Environment shared between all batchs
  ce_name = "ce-${var.environment}-${var.application}-batchs"
  

}

