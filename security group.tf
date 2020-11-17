#######################################
# Create the Security Group associated to the Batch
#######################################
resource "aws_security_group" "sg-batch" {
  name        = "sgr-${var.environment}-${var.application}-batch"
  description = "Allow Private subnets access batch"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "sgr-${var.environment}-${var.application}-batch"
  }
}

#######################################
# Allow outbound traffic with no Restriction
#######################################
resource "aws_security_group_rule" "batch_www_egress_all" {
  type        = "egress"
  from_port   = "-1"
  to_port     = "-1"
  protocol    = "all"
  description = "Allow all Outbound Traffic for Batch"

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-batch.id
}
