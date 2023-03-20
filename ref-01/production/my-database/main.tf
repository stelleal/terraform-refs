resource "aws_cloudwatch_metric_alarm" "database_CPUUtilization" {
  alarm_name          = "my-database-PROD-CPU-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 3
  alarm_actions       = [local.discord_alarm_sns]
  alarm_description   = "Alarm about CPUUtilization in my-prod-database (RDS) is GreaterThanOrEqualToThreshold"

  dimensions = {
    DBInstanceIdentifier = "my-prod-database"
  }

  tags = {
    Name = "my-database-prod-CPUUtilization-alarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "database_FreeRAM" {
  alarm_name          = "my-database-PROD-FreeRAM-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = 1000000000
  evaluation_periods  = 5
  datapoints_to_alarm = 3
  alarm_actions       = [local.discord_alarm_sns]
  alarm_description   = "Alarm about FreeRAM in my-prod-database (RDS) is LessThanOrEqualToThreshold"

  dimensions = {
    DBInstanceIdentifier = "my-prod-database"
  }

  tags = {
    Name = "my-database-prod-FreeableMemory-alarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "database_ReadLatency" {
  alarm_name          = "my-database-PROD-ReadLatency-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "ReadLatency"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Maximum"
  threshold           = 0.5
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  alarm_actions       = [local.discord_alarm_sns]
  alarm_description   = "Alarm about ReadLatency in my-prod-database (RDS) is GreaterThanOrEqualToThreshold"

  dimensions = {
    DBInstanceIdentifier = "my-prod-database"
  }

  tags = {
    Name = "my-database-prod-ReadLatency-alarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "database_WriteLatency" {
  alarm_name          = "my-database-PROD-WriteLatency-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "WriteLatency"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Maximum"
  threshold           = 0.5
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  alarm_actions       = [local.discord_alarm_sns]
  alarm_description   = "Alarm about WriteLatency in my-prod-database (RDS) is GreaterThanOrEqualToThreshold"

  dimensions = {
    DBInstanceIdentifier = "my-prod-database"
  }

  tags = {
    Name = "my-database-prod-WriteLatency-alarm"
  }
}
