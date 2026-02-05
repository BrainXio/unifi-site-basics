locals {
  # ──────────────────────────────────────────────────────────────────────────────
  # LAN / Site Network Details
  # ──────────────────────────────────────────────────────────────────────────────
  lan_subnet = data.unifi_network.site.subnet # e.g. "192.168.1.0/24"
  site_name  = data.unifi_network.site.site

  # Classify the address space of the LAN subnet (expanded to include D & E)
  site_class = (
    # Class A – starts with 0–9 (but only 1–126 valid; 0 & 127 reserved)
    can(regex("^([1-9]|[1-9][0-9]|1[0-1][0-9]|12[0-6])\\.", local.lan_subnet)) ? "A (private)" :

    # Class B – starts with 128–191
    # Private subset: only 172.16–172.31
    can(regex("^172\\.(1[6-9]|2[0-9]|3[0-1])\\.", local.lan_subnet)) ? "B (private)" :

    # Class C – starts with 192–223
    # Private subset: only 192.168.0.0–192.168.255.255
    can(regex("^192\\.168\\.", local.lan_subnet)) ? "C (private)" :

    # Class D – multicast (224–239)
    can(regex("^(22[4-9]|23[0-9])\\.", local.lan_subnet)) ? "D (multicast)" :

    # Class E – reserved/experimental (240–255)
    can(regex("^(24[0-9]|25[0-5])\\.", local.lan_subnet)) ? "E (reserved)" :

    "other"
  )

  # Fallback supernet only for valid private unicast ranges (A/B/C)
  # Class D/E get no fallback → forces error if used for unicast purposes
  site_cidr = (
    local.site_class == "A (private)" ? "10.0.0.0/8" :
    local.site_class == "B (private)" ? "172.16.0.0/12" :
    local.site_class == "C (private)" ? "192.168.0.0/16" :
    null # ← important: no fallback for D, E, other → downstream logic can fail safely
  )

  # Optional: safety check (prevents silent fallback to invalid 0.0.0.0/0)
  # You can reference this in a resource precondition or check block
  valid_private_cidr = local.site_cidr != null ? true : false

  # ──────────────────────────────────────────────────────────────────────────────
  # Teleport VPN Subnet – VLSM carved from the .100 block
  # ──────────────────────────────────────────────────────────────────────────────

  # Step 1: Always reserve the 192.168.100.0/24 (or equivalent) block
  teleport_parent_block = cidrsubnet(local.site_cidr, 8, var.teleport_block_third_octet)

  # Step 2: Determine how many extra bits we need inside the /24
  #         (higher extra_bits → smaller subnet → fewer clients supported)
  teleport_extra_bits = (
    var.teleport_consumers <= 5 ? 5 :   # → /29   ≈  6 usable IPs
    var.teleport_consumers <= 13 ? 4 :  # → /28   ≈ 14 usable
    var.teleport_consumers <= 29 ? 3 :  # → /27   ≈ 30 usable
    var.teleport_consumers <= 60 ? 2 :  # → /26   ≈ 62 usable
    var.teleport_consumers <= 120 ? 1 : # → /25   ≈126 usable
    0                                   # → /24   ≈254 usable (safe default)
  )

  # Step 3: Carve the final subnet from the /24 block (starting at the lowest address)
  teleport_auto_subnet = (
    local.valid_private_cidr ?
    cidrsubnet(local.teleport_parent_block, local.teleport_extra_bits, 0) :
    "0.0.0.0/0" # or error via precondition
  )
  teleport_subnet = var.teleport_subnet == "auto" ? local.teleport_auto_subnet : var.teleport_subnet
}

check "valid_private_address_space" {
  assert {
    condition     = local.valid_private_cidr
    error_message = "LAN subnet (${local.lan_subnet}) is not in a recognized RFC 1918 private range → cannot safely calculate Teleport subnet. Class detected: ${local.site_class}"
  }
}
