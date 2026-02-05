# ──────────────────────────────────────────────────────────────────────────────
# variables.tf – UniFi Site Settings (All Categories: Management, Network Optimization, NTP, RADIUS, SSL Inspection, Teleport, USW, Auto Speedtest, Country, DPI, LCD Monitor, Magic Site-to-Site VPN, etc.)
# ──────────────────────────────────────────────────────────────────────────────
# This file includes variables for all UniFi setting resources, grouped by category.
# Defaults match your provided code where possible, with validations based on official docs (e.g., ranges, enums).

variable "unifi_api_url" {
  description = "Base URL of your UniFi controller (no trailing /api)"
  type        = string
  default     = "https://192.168.1.1"
}

variable "unifi_allow_insecure" {
  description = "Allow self-signed/invalid certificates"
  type        = bool
  default     = true
}

variable "unifi_site" {
  description = "Site name ('default' in most single-site setups)"
  type        = string
  default     = "default"
}

variable "lan_network_name" {
  description = "Name of the primary LAN network in UniFi UI"
  type        = string
  default     = "Default"
}

# ── Auto Speedtest Settings (unifi_setting_auto_speedtest) ─────────────────────
# Note: Based on provider patterns; enabled required, cron optional with cron syntax constraint.

variable "auto_speedtest_enabled" {
  description = "Enable automatic speedtest functionality"
  type        = bool
  default     = true
}

variable "auto_speedtest_cron" {
  description = "Cron schedule for running speedtests (e.g., '0 0 * * *' for midnight daily)"
  type        = string
  default     = "0 0 * * *"

  validation {
    condition     = length(split(" ", var.auto_speedtest_cron)) == 5
    error_message = "auto_speedtest_cron must be a valid 5-field cron expression (minute, hour, day-of-month, month, day-of-week)."
  }
}

# ── Country Settings (unifi_setting_country) ───────────────────────────────────
# Note: Code is ISO 3166-1 alpha-2, required.

variable "country_code" {
  description = "Country code in ISO 3166-1 alpha-2 format (e.g., 'US' for United States)"
  type        = string
  default     = "US"

  validation {
    condition     = can(regex("^[A-Z]{2}$", var.country_code))
    error_message = "country_code must be a 2-letter uppercase ISO 3166-1 alpha-2 code."
  }
}

# ── DPI Settings (unifi_setting_dpi) ───────────────────────────────────────────
# Per docs: Both booleans required, no defaults.

variable "dpi_enabled" {
  description = "Enable Deep Packet Inspection (DPI) for traffic analysis"
  type        = bool
  default     = true
}

variable "dpi_fingerprinting_enabled" {
  description = "Enable DPI fingerprinting for application/service identification"
  type        = bool
  default     = true
}

# ── LCD Monitor Settings (unifi_setting_lcd_monitor) ───────────────────────────
# Per docs: Enabled required; others optional with ranges.

variable "lcd_monitor_enabled" {
  description = "Enable LCD display on supported devices (e.g., UDM Pro, UNVR)"
  type        = bool
  default     = true
}

variable "lcd_monitor_brightness" {
  description = "LCD display brightness level"
  type        = number
  default     = 100

  validation {
    condition     = var.lcd_monitor_brightness >= 1 && var.lcd_monitor_brightness <= 100
    error_message = "lcd_monitor_brightness must be between 1 and 100."
  }
}

variable "lcd_monitor_idle_timeout" {
  description = "Idle timeout in seconds before display turns off"
  type        = number
  default     = 3600

  validation {
    condition     = var.lcd_monitor_idle_timeout >= 10 && var.lcd_monitor_idle_timeout <= 3600
    error_message = "lcd_monitor_idle_timeout must be between 10 and 3600 seconds."
  }
}

variable "lcd_monitor_sync" {
  description = "Synchronize display settings across multiple devices"
  type        = bool
  default     = true
}

variable "lcd_monitor_touch_event" {
  description = "Enable touch interactions on the display"
  type        = bool
  default     = true
}

# ── Magic Site-to-Site VPN Settings (unifi_setting_magic_site_to_site_vpn) ─────
# Per docs: Enabled required.

variable "magic_site_to_site_vpn_enabled" {
  description = "Enable Magic Site-to-Site VPN functionality"
  type        = bool
  default     = false
}

# ── Management Settings (unifi_setting_mgmt) ───────────────────────────────────

variable "auto_upgrade" {
  description = "Whether devices should automatically upgrade firmware"
  type        = bool
  default     = true
}

variable "auto_upgrade_hour" {
  description = "Hour (0–23) when automatic upgrades are allowed/started"
  type        = number
  default     = 3

  validation {
    condition     = var.auto_upgrade_hour >= 0 && var.auto_upgrade_hour <= 23
    error_message = "auto_upgrade_hour must be between 0 and 23."
  }
}

variable "advanced_feature_enabled" {
  description = "Enable advanced features in the UniFi UI"
  type        = bool
  default     = true
}

variable "alert_enabled" {
  description = "Enable system alerts"
  type        = bool
  default     = true
}

variable "boot_sound" {
  description = "Play startup/shutdown sound on UniFi devices"
  type        = bool
  default     = false
}

variable "debug_tools_enabled" {
  description = "Enable debug tools in the controller (requires UniFi controller v7.3+)"
  type        = bool
  default     = false
}

variable "direct_connect_enabled" {
  description = "Enable direct connect (bypassing STUN for certain scenarios)"
  type        = bool
  default     = false
}

variable "led_enabled" {
  description = "Enable status LEDs on devices"
  type        = bool
  default     = true
}

variable "outdoor_mode_enabled" {
  description = "Enable outdoor mode (affects some default behaviors)"
  type        = bool
  default     = false
}

variable "unifi_idp_enabled" {
  description = "Enable UniFi Identity Provider integration"
  type        = bool
  default     = false
}

variable "wifiman_enabled" {
  description = "Enable WiFiman integration/telemetry"
  type        = bool
  default     = true
}

# ── SSH Settings (unifi_setting_mgmt) ──────────────────────────────────────────

variable "ssh_enabled" {
  description = "Allow SSH access to devices managed by this controller (enable temporarily for security)"
  type        = bool
  default     = false
}

variable "ssh_auth_password_enabled" {
  description = "Allow password authentication over SSH (less secure)"
  type        = bool
  default     = false
}

variable "ssh_bind_wildcard" {
  description = "Bind SSH server to 0.0.0.0 instead of specific interfaces"
  type        = bool
  default     = false
}

variable "ssh_username" {
  description = "Username for SSH access when password auth is enabled"
  type        = string
  default     = "admin"

  validation {
    condition     = length(var.ssh_username) >= 1
    error_message = "SSH username cannot be empty."
  }
}

variable "ssh_keys" {
  description = "List of SSH public keys to authorize on devices (preferred over passwords)"
  type = list(object({
    name    = string
    type    = string # e.g., "ssh-rsa", "ssh-ed25519"
    key     = string
    comment = optional(string) # optional description/email
  }))
  default   = []
  sensitive = true # marks the whole list sensitive (good practice)

  validation {
    condition = alltrue([
      for k in var.ssh_keys :
      contains(["ssh-rsa", "ecdsa-sha2-nistp256", "ecdsa-sha2-nistp384", "ecdsa-sha2-nistp521", "ssh-ed25519"], k.type)
    ])
    error_message = "Supported key types: ssh-rsa, ecdsa-*, ssh-ed25519."
  }
}

# ── Network Optimization Settings (unifi_setting_network_optimization) ──────────

variable "network_optimization_enabled" {
  description = "Enable network optimization features (e.g., band steering, airtime fairness)"
  type        = bool
  default     = true
}

# ── NTP Settings (unifi_setting_ntp) ───────────────────────────────────────────

variable "ntp_mode" {
  description = "NTP configuration mode ('auto' uses controller defaults; 'manual' requires servers)"
  type        = string
  default     = "manual"

  validation {
    condition     = contains(["auto", "manual"], var.ntp_mode)
    error_message = "ntp_mode must be 'auto' or 'manual'."
  }
}

variable "ntp_server_1" {
  description = "Primary NTP server hostname or IP (required for 'manual' mode)"
  type        = string
  default     = "time.cloudflare.com"
}

variable "ntp_server_2" {
  description = "Secondary NTP server hostname or IP"
  type        = string
  default     = "pool.ntp.org"
}

variable "ntp_server_3" {
  description = "Tertiary NTP server hostname or IP"
  type        = string
  default     = "time.google.com"
}

variable "ntp_server_4" {
  description = "Quaternary NTP server hostname or IP"
  type        = string
  default     = "0.pool.ntp.org"
}

# ── RADIUS Settings (unifi_setting_radius) ─────────────────────────────────────

variable "radius_enabled" {
  description = "Enable built-in RADIUS server functionality"
  type        = bool
  default     = false
}

variable "radius_secret" {
  description = "Shared secret for RADIUS clients (use random_password or secrets manager)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "radius_accounting_enabled" {
  description = "Enable RADIUS accounting for session tracking"
  type        = bool
  default     = true
}

variable "radius_auth_port" {
  description = "UDP port for RADIUS authentication"
  type        = number
  default     = 1812

  validation {
    condition     = var.radius_auth_port >= 1 && var.radius_auth_port <= 65535
    error_message = "radius_auth_port must be between 1 and 65535."
  }
}

variable "radius_accounting_port" {
  description = "UDP port for RADIUS accounting"
  type        = number
  default     = 1813

  validation {
    condition     = var.radius_accounting_port >= 1 && var.radius_accounting_port <= 65535
    error_message = "radius_accounting_port must be between 1 and 65535."
  }
}

variable "radius_interim_update_interval" {
  description = "Interval (seconds) for RADIUS client statistic updates"
  type        = number
  default     = 3600

  validation {
    condition     = var.radius_interim_update_interval > 0
    error_message = "radius_interim_update_interval must be positive."
  }
}

variable "radius_tunneled_reply" {
  description = "Enable encrypted RADIUS tunneling for added security"
  type        = bool
  default     = true
}

# ── SSL Inspection Settings (unifi_setting_ssl_inspection) ─────────────────────

variable "ssl_inspection_state" {
  description = "SSL inspection mode ('off', 'simple', or 'advanced')"
  type        = string
  default     = "advanced"

  validation {
    condition     = contains(["off", "simple", "advanced"], var.ssl_inspection_state)
    error_message = "ssl_inspection_state must be 'off', 'simple', or 'advanced'."
  }
}

# ── Teleport Settings (unifi_setting_teleport) ─────────────────────────────────

variable "teleport_enabled" {
  description = "Enable Teleport remote access functionality"
  type        = bool
  default     = false
}

variable "teleport_subnet" {
  description = "CIDR subnet for Teleport VPN clients (e.g., '192.168.100.0/24'); set to 'auto' for automatic calculation based on expected consumers"
  type        = string
  default     = "auto"

  validation {
    condition     = var.teleport_subnet == "auto" || can(cidrnetmask(var.teleport_subnet))
    error_message = "teleport_subnet must be 'auto' or a valid IPv4 CIDR block (e.g., '192.168.100.0/24')."
  }
}

variable "teleport_block_third_octet" {
  description = "Third octet to use when carving the Teleport parent /24 block (default 100)"
  type        = number
  default     = 100

  validation {
    condition     = var.teleport_block_third_octet >= 1 && var.teleport_block_third_octet <= 254
    error_message = "Third octet must be between 1 and 254."
  }
}

variable "teleport_consumers" {
  description = "Expected / planned number of Teleport clients (for documentation & capacity planning only — not enforced by UniFi/Terraform)"
  type        = number
  default     = 100

  validation {
    condition     = var.teleport_consumers >= 1 && var.teleport_consumers <= 100
    error_message = "Expected client count should be realistic (1–100)."
  }
}

# ── Switch Settings (unifi_setting_usw) ────────────────────────────────────────

variable "usw_dhcp_snoop" {
  description = "Enable DHCP snooping to protect against rogue DHCP servers"
  type        = bool
  default     = true
}
