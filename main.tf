module landingzone {
  source = "./gcat-landing-zone"
  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group = var.resource_group
  prefix = var.unique_token
  region = var.region
  machine_type = var.cluster_worker_flavor
  workers_per_zone = var.workers_per_zone
  entitlement = ""
  kube_version = var.kube_version
  worker_pools = var.worker_pools
  subnets = var.subnets
  access_groups = var.access_groups
  disable_public_service_endpoint = var.disable_public_service_endpoint
}

# Create transit gateway and connect to VPC and classic
module tg {
  source = "./tg"
  region = var.region
  unique_token = var.unique_token
  resource_group = module.landingzone.resource_group_id
  vpc_crn = module.landingzone.vpc_crn

}

module classic {
  source = "./classic"
  unique_token = var.unique_token
  classic_private_vlan = var.classic_private_vlan
  classic_private_vlan_router = var.classic_private_vlan_router
  ssh_key = var.ssh_key
  vsi_datacenter = var.vsi_datacenter
  vsi_hostname = var.vsi_hostname
  vsi_domain = var.vsi_domain
}

module cis {
  source = "./cis"
  unique_token = var.unique_token
  resource_group = module.landingzone.resource_group_id
}