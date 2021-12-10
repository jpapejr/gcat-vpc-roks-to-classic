output vsi_id {
    value = ibm_compute_vm_instance.vsi.id
    description = "ID for the classic VSI"
}

output vsi_ip {
    value = ibm_compute_vm_instance.vsi.ipv4_address_private
    description = "Private IP for the classic instance"
}