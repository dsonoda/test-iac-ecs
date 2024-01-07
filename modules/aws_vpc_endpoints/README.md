<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_iam_policy_document.vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "Environment": "",<br>  "Provisioner": "terraform",<br>  "Service": ""<br>}</pre> | no |
| <a name="input_enable_ecs_exec"></a> [enable\_ecs\_exec](#input\_enable\_ecs\_exec) | Whether to enable ECS Exec functionality | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | resource name prefix | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | list of security group ids | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | list of subnet ids | `list(string)` | `[]` | no |
| <a name="input_vpc_endpoint_gateway_settings"></a> [vpc\_endpoint\_gateway\_settings](#input\_vpc\_endpoint\_gateway\_settings) | type gateway vpc endpoint settings | <pre>list(object({<br>    vpce_name                = string<br>    associate_route_table_id = string<br>  }))</pre> | <pre>[<br>  {<br>    "associate_route_table_id": "",<br>    "vpce_name": ""<br>  }<br>]</pre> | no |
| <a name="input_vpc_endpoint_interface_settings"></a> [vpc\_endpoint\_interface\_settings](#input\_vpc\_endpoint\_interface\_settings) | type interface vpc endpoint settings | <pre>list(object({<br>    is_ecs_exec_rsc     = bool<br>    vpce_name           = string<br>    private_dns_enabled = bool<br>  }))</pre> | <pre>[<br>  {<br>    "is_ecs_exec_rsc": false,<br>    "private_dns_enabled": false,<br>    "vpce_name": ""<br>  }<br>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_endpoint_gateway_ids"></a> [vpc\_endpoint\_gateway\_ids](#output\_vpc\_endpoint\_gateway\_ids) | n/a |
| <a name="output_vpc_endpoint_interface_ids"></a> [vpc\_endpoint\_interface\_ids](#output\_vpc\_endpoint\_interface\_ids) | n/a |
<!-- END_TF_DOCS -->