# Variables
variable unique_token {
    description = "A unique string to be prepended to all resources created"
    type = string
    default = "gcat-landing-vpc-to-classic"
}
variable resource_group {
    description = "Name of the target IBM Cloud resource group"
    type = string
    default = "gcat-landing"
}
variable plan {
  description = "Service plan for CIS instance"
  default = "standard"
  type = string
}