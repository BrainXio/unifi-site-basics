# outputs.tf

output "id" {
  description = "The unique identifier of the applied management settings object (from unifi_setting_mgmt resource)"
  value       = unifi_setting_mgmt.site.id
}

output "rfc1918_compliant" {
  description = "Whether the LAN subnet falls within a valid RFC 1918 private address range (true/false)"
  value       = local.valid_private_cidr
}

output "site_cidr" {
  description = "The fallback private supernet CIDR block used for address space calculations (derived from RFC 1918 classification)"
  value       = local.site_cidr
}

output "site_class" {
  description = "Detected address class of the LAN subnet (A (private), B (private), C (private), D (multicast), E (reserved), or other)"
  value       = local.site_class
}

output "site_magic_enabled" {
  description = "Whether Magic Site-to-Site VPN is enabled on this site"
  value       = var.magic_site_to_site_vpn_enabled
}

output "site_radius_enabled" {
  description = "Whether the built-in RADIUS server is enabled on this site"
  value       = var.radius_enabled
}

output "site_ssh_enabled" {
  description = "Whether SSH access to managed devices is enabled (from management settings)"
  value       = var.ssh_enabled
}

output "site_teleport_enabled" {
  description = "Whether Teleport VPN is enabled on this site"
  value       = var.teleport_enabled
}
