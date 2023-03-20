output "eb_auto_scaling_groups" {
  value = aws_elastic_beanstalk_environment.beanstalk_app_env.autoscaling_groups
}