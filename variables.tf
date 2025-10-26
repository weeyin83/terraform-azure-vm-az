##
# Variables
##

##
# Common Variables
##

variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "availability_zone" {
  description = "Azure Availability Zone"
  type        = string
}
