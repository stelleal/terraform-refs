#VARIABLES
## Elastic Beanstalk Environment Variables
variable "some_url" {}
variable "some_secret_key" {}
variable "some_other_secret_key" {}


#LOCALS
locals {
  environment = "homol"
}
