#VARIABLES

#LOCALS
locals {
  discord_alarm_sns = data.aws_sns_topic.discord_alarm_sns.arn
}