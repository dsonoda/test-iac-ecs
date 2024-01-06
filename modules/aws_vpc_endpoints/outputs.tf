output "vpc_endpoint_interface_ids" {
  value = { for vpce_key, vpce_value in aws_vpc_endpoint.interface : vpce_key => vpce_value.id }
}

output "vpc_endpoint_gateway_ids" {
  value = aws_vpc_endpoint.gateway[*].id
}
