# https://aws.amazon.com/getting-started/hands-on/run-batch-jobs-at-scale-with-ec2-spot/

# added linked service roles
resource "aws_iam_service_linked_role" "AWSServiceRoleForEC2Spot" {
  aws_service_name = "spot.amazonaws.com"
}

resource "aws_iam_service_linked_role" "AWSServiceRoleForEC2SpotFleet" {
  aws_service_name = "spotfleet.amazonaws.com"
}

## AmazonEC2SpotFleetRole ###
resource "aws_iam_role" "AmazonEC2SpotFleetRole" {
  #name = "role-${var.environment}-${var.application}-ec2-spot-spleet-role"
  name = "AmazonEC2SpotFleetRole"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "spotfleet.amazonaws.com"
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEC2SpotFleetRole" {
  role       = aws_iam_role.AmazonEC2SpotFleetRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetTaggingRole"
}
