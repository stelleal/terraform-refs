# VARIABLES
variable "application_name" {}
variable "environment" {}

variable "solution_stack_name" {
  default     = "64bit Amazon Linux 2 v3.5.4 running Docker"
  description = "Default is a docker container environment."
}
variable "tier" {
  default = "WebServer"
}

## environment settings
variable "vpc_id" {}
variable "subnets_ids" {}

variable "scaling_lower_threshold" {
  default     = "50"
  description = "Percentage of CPU utilization to trigger a scale down event."
}
variable "scaling_upper_threshold" {
  default     = "80"
  description = "Percentage of CPU utilization to trigger a scale up event."
}
variable "instance_types" {
  default     = "t2.micro, t2.small"
  description = "List of instance types to use for the environment. Separate with commas."
}
variable "scaling_max_size" {
  default     = "4"
  description = "Maximum number of instances to scale up to."
}
variable "maintenance_window_start_time" {
  default     = "Sat:03:00"
  description = "Configure a maintenance window for managed actions in UTC."
}
variable "enable_health_logs_streaming" {
  type        = bool
  default     = false
  description = "Enable streaming of health logs to CloudWatch Logs."
}
variable "health_check_url" {
  default     = "/"
  description = "URL to use for health checks. Valid values: / /health HTTPS:443/ HTTPS:443/health , with health being an example"
}

variable "enable_https" {
  type        = bool
  default     = false
  description = "Enable HTTPS on the load balancer."
}
variable "ssl_certificate_arn" {
  default     = null
  description = "ARN of the SSL certificate to bind to the listener."
}

variable "env_variables" {
  type        = map(string)
  default     = null
  description = "A map of environment variables and their values."
  # Usage example
  #     env_variables = {
  #     MY_VARIABLE = "variable_value"
  #     ANOTHER_VARIABLE = "variable_value"
  #   }
}

# LOCALS

locals {
  custom_metrics_config_json = jsonencode({
    "Version" : 1,
    "CloudWatchMetrics" : {
      "Environment" : {
        "ApplicationRequests4xx" : 60,
        "ApplicationRequests5xx" : 60
      }
    }
  })
}
