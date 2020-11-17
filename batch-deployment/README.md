## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| batch\_instance\_profile\_arn | Instance Profile ARN | `string` | n/a | yes |
| batch\_job\_definition\_name | Batch Job definition name. | `string` | `"batch-job-definition"` | no |
| batch\_job\_queue\_name | Batch Job queue name. | `string` | `"batch-job-queue"` | no |
| batch\_job\_queue\_priority | Priority of the created Job Queue. | `string` | `"100"` | no |
| batch\_job\_queue\_state | State of the created Job Queue. | `string` | `"ENABLED"` | no |
| batch\_name | Batch name. Used in naming convention for iam resources | `string` | `"batch"` | no |
| batch\_service\_role\_arn | The Batch Service Role | `string` | n/a | yes |
| bid\_percentage | Integer of minimum percentage that a Spot Instance price must be when compared with the On-Demand price for that instance type before instances are launched. For example, if your bid percentage is 20% (20), then the Spot price must be below 20% of the current On-Demand price for that EC2 instance. | `number` | `100` | no |
| ce\_allocation\_strategy | The allocation strategy to use for the compute resource. | `string` | `"BEST_FIT"` | no |
| ce\_name | Given name for the Compute Environment. | `string` | `"main"` | no |
| ce\_type | Compute Environment type. | `string` | `"MANAGED"` | no |
| compute\_environment\_arn | The ARN of shared compute environment | `string` | `""` | no |
| create\_compute\_environment | Enable/Disable the creation of a dedicated compute environment | `bool` | `false` | no |
| desired\_vcpus | Desired number of VCPUs allocated to instances. | `number` | `1` | no |
| ecs\_container\_properties | A valid container properties provided as a single valid JSON document. | `any` | n/a | yes |
| environment | The environment on which we want create resources | `string` | n/a | yes |
| instance\_type | The instance\_type for compute environment to use. | `list(string)` | <pre>[<br>  "optimal"<br>]</pre> | no |
| max\_vcpus | Maximum allowed VCPUs allocated to instances. | `number` | `2` | no |
| min\_vcpus | Minimum number of VCPUs allocated to instances. | `number` | `0` | no |
| security\_groups | Security groups to be used by the Compute Environment. | `list(string)` | `[]` | no |
| spot\_iam\_fleet\_role\_arn | The Role ARN for spot fleet | `string` | n/a | yes |
| subnet\_ids | subnet id's for batch | `list(string)` | n/a | yes |
| tags | a map of tags to put on AWS Batch Resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| compute\_environment\_name | The CE name. |
| compute\_environment\_resources\_arn | The CE resources. |
| compute\_environment\_state | The CE state. |
| job\_definition\_arn | The Job definition ARN. |
| job\_definition\_container\_parameters | The Job definition parameters |
| job\_definition\_container\_properties | The Job definition container properties. |
| job\_queue\_arn | The Job queue ARN. |
| job\_queue\_state | Job queue state |

