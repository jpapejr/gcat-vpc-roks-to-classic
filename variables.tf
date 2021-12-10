# Variables
variable ibmcloud_api_key {
    default = "<ENTER AN API KEY HERE>"
    description = "An IBM Cloud IAM API key with permission to create VPC resources, ROKS clusters, and Transgit Gateway resources"
    sensitive = true
    type = string
}
variable region {
    description = "An IBM Cloud VPC compute region (e.g. us-east)"
    default = "us-east"
    type = string
}
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
variable classic_private_vlan{
    description = "Classic VLAN number (not ID) where classic compute will be created"
    type = string
    default = "<ENTER A CLASSIC VLAN NUMBER HERE>"
}
variable vsi_datacenter{
    description = "Classic data center to create classic compute. Must align with VLAN selected"
    type = string
    default = "<ENTER A CLASSIC DATA CENTER HERE>"
}
variable classic_private_vlan_router{
    description = "Classic BCR router where classic compute will be connected. Must align with data center and VLAN selection"
    type = string
    default = "<ENTER A CLASSIC VLAN NUMBER HERE>"
}
variable ssh_key{
    description = "Classic SSH Key for accessing created compute instances"
    type = string
    default = "<ENTER A CLASSIC SSH KEY NAME HERE>"
}

variable vsi_hostname {
    description = "Hostname for the classic compute instance"
    type = string
    default = "test-vsi"
}

variable vsi_domain {
    description = "Domain name for the classic compute instance"
    type = string
    default = "test.cloud"
}

variable cluster_worker_flavor {
    description = "VPC instance profile for ROKS workers"
    type = string
    default = "bx2.4x16"
}

variable workers_per_zone {
    description = "Count of ROKS workers per zone"
    type = number
    default = 3
}

variable kube_version {
    description = "OpenShift version"
    default = "4.8_openshift"
    type = string
}

variable worker_pools {
    default = []
    description = "Additional ROKS worker pool definitions"
    type        = list(object({
        name        = string
        machine_type     = string
        workers_per_zone = number
    }))
}

variable disable_public_service_endpoint {
    default = false
    type = bool
    description = "If true, provision the cluster with private master endpoints"
}

variable TF_VERSION {
 default     = "1.0"
 type        = string
 description = "The version of the Terraform engine that's used in the Schematics workspace."
}

variable subnets {
  description = "List of subnets for the vpc. For each item in each array, a subnet will be created."
  type        = object({
    zone-1 = list(object({
      name           = string
      cidr           = string
      public_gateway = optional(bool)
    }))
    zone-2 = list(object({
      name           = string
      cidr           = string
      public_gateway = optional(bool)
    }))
    zone-3 = list(object({
      name           = string
      cidr           = string
      public_gateway = optional(bool)
    }))
  })
  default = {
    zone-1 = [
      {
        name           = "subnet-az1-01"
        cidr           = "10.10.10.0/24"
        public_gateway = true
      }
    ],
    zone-2 = [],
    zone-3 = []
  }
}

variable access_groups {
    description = "A list of access groups to create"
    type        = list(
        object({
            name        = string # Name of the group
            description = string # Description of group
            policies    = list(
                object({
                    name      = string       # Name of the policy
                    roles     = list(string) # list of roles for the policy
                    resources = object({
                        resource_group       = optional(string) # Name of the resource group the policy will apply to
                        resource_type        = optional(string) # Name of the resource type for the policy ex. "resource-group"
                        service              = optional(string) # Name of the service type for the policy ex. "cloud-object-storage"
                        resource_instance_id = optional(string) # ID of a service instance to give permissions
                    })
                })
            )
            dynamic_policies = optional(
                list(
                    object({
                        name              = string # Dynamic group name
                        identity_provider = string # URI for identity provider
                        expiration        = number # How many hours authenticated users can work before refresh
                        conditions        = object({
                                claim    = string # key value to evaluate the condition against.
                                operator = string # The operation to perform on the claim. Supported values are EQUALS, EQUALS_IGNORE_CASE, IN, NOT_EQUALS_IGNORE_CASE, NOT_EQUALS, and CONTAINS.
                                value    = string # Value to be compared agains
                        })
                    })
                )
            )
            account_management_policies = optional(list(string))
            invite_users                = list(string) # Users to invite to the access group
        })
    )
    default       = []
    # default     = [
    #     {
    #         name        = "admin"
    #         description = "An example admin group"
    #         policies    = [
    #             {
    #                 name = "admin_all"
    #                 resources = {
    #                     resource_group = "gcat-landing-zone-dev"
    #                 }
    #                 roles = ["Administrator","Manager"]
    #             }
    #         ]
    #         dynamic_policies = []
    #         invite_users = [ "test@test.test" ]
    #     },
    #     {
    #       name        = "dev"
    #       description = "A developer access group"
    #       policies    = [
    #         {
    #           name      = "dev_view_vpc"
    #           resources = {
    #             resource_group = "gcat-landing-zone-dev"
    #             service        = "id"
    #           }
    #           roles = ["Viewer"] 
    #         }
    #       ]
    #       invite_users = ["test@test.test"]
    #     }
    # ]
}