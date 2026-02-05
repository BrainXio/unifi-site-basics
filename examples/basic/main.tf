# examples/basic/main.tf

module "unifi_site_basics" {
  source = "../../" # or git source

  lan_network_name = "Default"

  # Only apply bare minimum
  teleport_enabled               = false
  radius_enabled                 = false
  magic_site_to_site_vpn_enabled = false
}

output "unifi_site_basics" {
  value = module.unifi_site_basics
}
