# Variables
variable region {
    description = "An IBM Cloud VPC compute region (e.g. us-east)"
    default = "us-east"
    type = string
}
variable unique_token {
    description = "A unique string to be prepended to all resources created"
    default = "gcat-landing-vpc-to-classic"
    type = string
}
variable resource_group {
    description = "Name of the target IBM Cloud resource group"
    type = string
    default = "gcat-landing"
}
variable vpc_crn {
    description = "CRN of the VPC that will be connected to this TG"
    type = string
}
