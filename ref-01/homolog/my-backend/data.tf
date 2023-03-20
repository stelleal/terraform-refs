data "aws_vpc" "vpc_homol" {
  filter {
    name   = "tag:Name"
    values = ["prefix-${local.environment}-vpc"]
  }
}

data "aws_subnets" "subnets_homol" {
  filter {
    name   = "tag:Name"
    values = ["prefix-my-product-${local.environment}-subnet-*"]
  }
}

output "app_backend_eb_autoscaling_groups" {
  value = module.app_backend_eb.eb_auto_scaling_groups
}