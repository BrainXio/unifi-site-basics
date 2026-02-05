data "unifi_network" "site" {
  name = var.lan_network_name
}

resource "unifi_setting_auto_speedtest" "site" {
  enabled = var.auto_speedtest_enabled
  cron    = var.auto_speedtest_cron
  site    = local.site_name
}

resource "unifi_setting_country" "site" {
  code = var.country_code
  site = local.site_name
}

resource "unifi_setting_dpi" "site" {
  enabled                = var.dpi_enabled
  fingerprinting_enabled = var.dpi_fingerprinting_enabled
  site                   = local.site_name
}

resource "unifi_setting_lcd_monitor" "site" {
  enabled      = var.lcd_monitor_enabled
  brightness   = var.lcd_monitor_brightness
  idle_timeout = var.lcd_monitor_idle_timeout
  site         = local.site_name
  sync         = var.lcd_monitor_sync
  touch_event  = var.lcd_monitor_touch_event
}

resource "unifi_setting_magic_site_to_site_vpn" "site" {
  enabled = var.magic_site_to_site_vpn_enabled
  site    = local.site_name
}

resource "unifi_setting_mgmt" "site" {
  site = local.site_name

  # ── Auto-upgrade ─────────────────────────────────────────────────────────────
  auto_upgrade      = var.auto_upgrade
  auto_upgrade_hour = var.auto_upgrade_hour

  # ── Device / UI features ─────────────────────────────────────────────────────
  advanced_feature_enabled = var.advanced_feature_enabled
  alert_enabled            = var.alert_enabled
  boot_sound               = var.boot_sound
  debug_tools_enabled      = var.debug_tools_enabled
  direct_connect_enabled   = var.direct_connect_enabled
  led_enabled              = var.led_enabled
  outdoor_mode_enabled     = var.outdoor_mode_enabled
  unifi_idp_enabled        = var.unifi_idp_enabled
  wifiman_enabled          = var.wifiman_enabled

  # ── SSH configuration ────────────────────────────────────────────────────────
  ssh_enabled               = var.ssh_enabled
  ssh_auth_password_enabled = var.ssh_auth_password_enabled
  ssh_bind_wildcard         = var.ssh_bind_wildcard
  ssh_username              = var.ssh_username

  # Dynamic block – only created when list is non-empty
  dynamic "ssh_key" {
    for_each = var.ssh_keys

    content {
      name    = ssh_key.value.name
      type    = ssh_key.value.type
      key     = ssh_key.value.key
      comment = try(ssh_key.value.comment, null) # optional field
    }
  }

  lifecycle {
    ignore_changes = [ssh_key]
  }
}

resource "unifi_setting_network_optimization" "site" {
  enabled = var.network_optimization_enabled
  site    = local.site_name
}

resource "unifi_setting_ntp" "site" {
  mode         = var.ntp_mode
  ntp_server_1 = var.ntp_server_1
  ntp_server_2 = var.ntp_server_2
  ntp_server_3 = var.ntp_server_3
  ntp_server_4 = var.ntp_server_4
  site         = local.site_name
}

resource "random_password" "radius" {
  count            = length(var.radius_secret) < 1 ? 1 : 0
  length           = 48
  special          = true
  upper            = true
  lower            = true
  numeric          = true
  override_special = "@#$%"
}

resource "unifi_setting_radius" "site" {
  enabled                 = var.radius_enabled
  secret                  = length(var.radius_secret) < 1 ? random_password.radius[0].result : var.radius_secret
  accounting_enabled      = var.radius_accounting_enabled
  auth_port               = var.radius_auth_port
  accounting_port         = var.radius_accounting_port
  interim_update_interval = var.radius_interim_update_interval
  tunneled_reply          = var.radius_tunneled_reply
  site                    = local.site_name
}

resource "unifi_setting_ssl_inspection" "site" {
  state = var.ssl_inspection_state
  site  = local.site_name
}

resource "unifi_setting_teleport" "site" {
  enabled = var.teleport_enabled
  subnet  = local.teleport_subnet
  site    = local.site_name
}

resource "unifi_setting_usw" "site" {
  dhcp_snoop = var.usw_dhcp_snoop
  site       = local.site_name
}
