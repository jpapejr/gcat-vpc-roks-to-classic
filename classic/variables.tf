# Variables
variable unique_token {
    description = "A unique string to be prepended to all resources created"
    type = string
    default = "gcat-landing-vpc-to-classic"
}
variable classic_private_vlan{
    description = "Classic VLAN number (not ID) where classic compute will be created"
    type = string
}
variable vsi_datacenter{
    description = "Classic data center to create classic compute. Must align with VLAN selected"
    type = string
}
variable classic_private_vlan_router{
    description = "Classic BCR router where classic compute will be connected. Must align with data center and VLAN selection"
    type = string
}
variable ssh_key{
    description = "Classic SSH Key for accessing created compute instances"
    type = string
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