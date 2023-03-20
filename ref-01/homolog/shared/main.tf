data "aws_vpc" "homol_vpc" {
  id = "vpc-00000abc"
}

output "homol_vpc" {
  value = data.aws_vpc.homol_vpc
}

module "my-subnets" {
  source                 = "../../modules/subnet"
  project_name           = "my-product-${local.environment}"
  vpc_id                 = data.aws_vpc.homol_vpc.id
  subnets_cidr_blocks    = ["10.0.0.0/20", "10.0.16.0/20"]
  avail_zone             = ["us-east-1a", "us-east-1b"]
  default_route_table_id = data.aws_vpc.homol_vpc.main_route_table_id
}