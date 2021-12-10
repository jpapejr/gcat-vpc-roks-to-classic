

resource "ibm_cis" "cis_instance" {
  name              = "${var.unique_token}-cis"
  plan              = var.plan
  resource_group_id = var.resource_group
  location          = "global"

  //User can increase timeouts
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}