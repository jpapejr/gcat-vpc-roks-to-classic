# Create a VSI on the designed private vlan
data "ibm_network_vlan" "vlan" {
  number = var.classic_private_vlan
  router_hostname = var.classic_private_vlan_router
}

data "ibm_compute_ssh_key" "public_key" {
    label = var.ssh_key 
}

resource "ibm_compute_vm_instance" "vsi" {
  hostname                   = var.vsi_hostname
  domain                     = var.vsi_domain
  os_reference_code          = "UBUNTU_20_64"
  datacenter                 = var.vsi_datacenter
  network_speed              = 10
  hourly_billing             = true
  private_network_only       = true
  cores                      = 1
  memory                     = 2048 
  disks                      = [25]
  local_disk                 = false
  private_vlan_id            = data.ibm_network_vlan.vlan.id
  ssh_key_ids                = [data.ibm_compute_ssh_key.public_key.id]
}
