#########
# AWS VPC Endpoint
#########

# policy
data "aws_iam_policy_document" "vpc_endpoint" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

# endpoint
## enable_ecs_exec = false && is_ecs_exec_rsc = true  : not create
## enable_ecs_exec = false && is_ecs_exec_rsc = false : create
## enable_ecs_exec = true  && is_ecs_exec_rsc = true  : create
## enable_ecs_exec = true  && is_ecs_exec_rsc = false : create
resource "aws_vpc_endpoint" "interface" {
  for_each = { for idx, setting in var.vpc_endpoint_interface_settings : idx => setting if !(!var.enable_ecs_exec && setting.is_ecs_exec_rsc) }

  vpc_id              = var.vpc_id
  service_name        = format("com.amazonaws.%s.%s", var.region, each.value.vpce_name)
  vpc_endpoint_type   = "Interface"
  policy              = data.aws_iam_policy_document.vpc_endpoint.json
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = each.value.private_dns_enabled

  tags = merge(var.common_tags, ({
    "Name" : format("%s-vpce-%s", var.prefix, each.value.vpce_name)
  }))
}

resource "aws_vpc_endpoint" "gateway" {
  count = length(var.vpc_endpoint_gateway_settings)

  vpc_id            = var.vpc_id
  service_name      = format("com.amazonaws.%s.%s", var.region, var.vpc_endpoint_gateway_settings[count.index].vpce_name)
  vpc_endpoint_type = "Gateway"
  policy            = data.aws_iam_policy_document.vpc_endpoint.json

  tags = merge(var.common_tags, ({
    "Name" : format("%s-vpce-%s", var.prefix, var.vpc_endpoint_gateway_settings[count.index].vpce_name)
  }))
}

resource "aws_vpc_endpoint_route_table_association" "gateway" {
  count = length(var.vpc_endpoint_gateway_settings)

  route_table_id  = var.vpc_endpoint_gateway_settings[count.index].associate_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.gateway[count.index].id
}
