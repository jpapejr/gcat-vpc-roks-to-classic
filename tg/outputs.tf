output tg_id {
  value = ibm_tg_gateway.tg_gw.id
  description = "Transit Gateway GUID"
}

output tg_name {
    value = ibm_tg_gateway.tg_gw.name
    description = "Transit Gateway name"
}

output tg_location {
    value = ibm_tg_gateway.tg_gw.location
    description = "Transit Gateway location"
}