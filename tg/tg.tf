# Create transit gateway and connect to VPC and classic
resource "ibm_tg_gateway" "tg_gw" {
  name = "${var.unique_token}-tg"
  location = var.region
  global = true
  resource_group = var.resource_group
}


resource "ibm_tg_connection" "tg_connection-vpc" {
  gateway      = ibm_tg_gateway.tg_gw.id
  network_type = "vpc"
  name         = "${var.unique_token}-vpc-connection"
  network_id   =  var.vpc_crn
}

resource "ibm_tg_connection" "tg_connection-classic" {
  gateway      = ibm_tg_gateway.tg_gw.id
  network_type = "classic"
  name         = "${var.unique_token}-classic-connection"
}