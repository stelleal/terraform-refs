data "aws_vpc" "prod_vpc" {
  id = "vpc-000000aaa"
}

module "my-subnet" {
  source                 = "../../modules/subnet"
  project_name           = "my-product-${local.environment}"
  vpc_id                 = data.aws_vpc.prod_vpc.id
  subnets_cidr_blocks    = ["10.0.0.0/20", "10.0.16.0/20"]
  avail_zone             = ["us-east-1a", "us-east-1b"]
  default_route_table_id = data.aws_vpc.prod_vpc.main_route_table_id
}

# ==============================

resource "aws_codeartifact_domain" "ca_domain" {
  domain = "my-domain"
}

resource "aws_codeartifact_repository" "ca_repo" {
  domain      = aws_codeartifact_domain.ca_domain.domain
  repository  = "npm"
  description = "NPM repository for project"
}

# Create a OICD provider for GitHub to interact with AWS codeartifact
resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "github-thumbprint-here",
  ]

  tags = {
    Name = "github-oidc"
  }
}

output "github_oidc_arn" {
  value = aws_iam_openid_connect_provider.github_oidc_provider.arn
}

# ==============================

resource "aws_sns_topic" "discord_alarms_sns" {
  name = "my-discord-alarm"

  tags = {
    Name = "sns-alarms"
  }
}

resource "aws_sns_topic_subscription" "discord_alarm_lambda" {
  topic_arn = aws_sns_topic.discord_alarms_sns.arn
  protocol  = "lambda"
  endpoint  = "arn:aws:lambda:us-east-1:0001110010:function:cloudwatch-discord-alarm"
}