# terraform state show module.app_backend_eb.aws_elastic_beanstalk_environment.beanstalk_app_env

module "app_backend_eb" {
  source           = "../../modules/elastic-beanstalk"
  application_name = "my-app"
  environment      = local.environment
  vpc_id           = data.aws_vpc.vpc_homol.id
  subnets_ids      = data.aws_subnets.subnets_homol.ids
  health_check_url = "/health"
  env_variables = {
    MY_ENV_VAR_1 = var.some_url
    MY_ENV_VAR_2 = var.some_secret_key
    MY_ENV_VAR_3 = var.some_other_secret_key
  }
}

resource "aws_elasticache_cluster" "app_redis" {
  cluster_id           = "my-app-redis"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.app_redis_subnet_group.name
}

resource "aws_elasticache_subnet_group" "app_redis_subnet_group" {
  name       = "my-app-redis-sg"
  subnet_ids = data.aws_subnets.subnets_homol.ids
}