<!-- BEGIN_TF_DOCS -->
# unifi-site-basics

<p align="center">
  <a href="https://github.com/BrainXio/unifi-site-basics/">
    <img src="https://github.com/BrainXio.png" alt="Logo" width=72 height=72>
  </a>

  <p align="center" style="font-size: 1.1em; font-style: italic;">
    "Build anything; automate everything, feel the space in between.."
  </p>
  <p align="center">
    <a href="https://github.com/BrainXio/unifi-site-basics/issues/new?template=bug.md">Report bug</a>
    ·
    <a href="https://github.com/BrainXio/unifi-site-basics/issues/new?template=feature.md&labels=feature">Request feature</a>
  </p>
</p>

---

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_unifi"></a> [unifi](#provider\_unifi) | 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.radius](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [unifi_setting_auto_speedtest.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_auto_speedtest) | resource |
| [unifi_setting_country.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_country) | resource |
| [unifi_setting_dpi.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_dpi) | resource |
| [unifi_setting_lcd_monitor.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_lcd_monitor) | resource |
| [unifi_setting_magic_site_to_site_vpn.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_magic_site_to_site_vpn) | resource |
| [unifi_setting_mgmt.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_mgmt) | resource |
| [unifi_setting_network_optimization.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_network_optimization) | resource |
| [unifi_setting_ntp.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_ntp) | resource |
| [unifi_setting_radius.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_radius) | resource |
| [unifi_setting_ssl_inspection.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_ssl_inspection) | resource |
| [unifi_setting_teleport.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_teleport) | resource |
| [unifi_setting_usw.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/resources/setting_usw) | resource |
| [unifi_network.site](https://registry.terraform.io/providers/filipowm/unifi/1.0.0/docs/data-sources/network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_feature_enabled"></a> [advanced\_feature\_enabled](#input\_advanced\_feature\_enabled) | Enable advanced features in the UniFi UI | `bool` | `true` | no |
| <a name="input_alert_enabled"></a> [alert\_enabled](#input\_alert\_enabled) | Enable system alerts | `bool` | `true` | no |
| <a name="input_auto_speedtest_cron"></a> [auto\_speedtest\_cron](#input\_auto\_speedtest\_cron) | Cron schedule for running speedtests (e.g., '0 0 * * *' for midnight daily) | `string` | `"0 0 * * *"` | no |
| <a name="input_auto_speedtest_enabled"></a> [auto\_speedtest\_enabled](#input\_auto\_speedtest\_enabled) | Enable automatic speedtest functionality | `bool` | `true` | no |
| <a name="input_auto_upgrade"></a> [auto\_upgrade](#input\_auto\_upgrade) | Whether devices should automatically upgrade firmware | `bool` | `true` | no |
| <a name="input_auto_upgrade_hour"></a> [auto\_upgrade\_hour](#input\_auto\_upgrade\_hour) | Hour (0–23) when automatic upgrades are allowed/started | `number` | `3` | no |
| <a name="input_boot_sound"></a> [boot\_sound](#input\_boot\_sound) | Play startup/shutdown sound on UniFi devices | `bool` | `false` | no |
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | Country code in ISO 3166-1 alpha-2 format (e.g., 'US' for United States) | `string` | `"US"` | no |
| <a name="input_debug_tools_enabled"></a> [debug\_tools\_enabled](#input\_debug\_tools\_enabled) | Enable debug tools in the controller (requires UniFi controller v7.3+) | `bool` | `false` | no |
| <a name="input_direct_connect_enabled"></a> [direct\_connect\_enabled](#input\_direct\_connect\_enabled) | Enable direct connect (bypassing STUN for certain scenarios) | `bool` | `false` | no |
| <a name="input_dpi_enabled"></a> [dpi\_enabled](#input\_dpi\_enabled) | Enable Deep Packet Inspection (DPI) for traffic analysis | `bool` | `true` | no |
| <a name="input_dpi_fingerprinting_enabled"></a> [dpi\_fingerprinting\_enabled](#input\_dpi\_fingerprinting\_enabled) | Enable DPI fingerprinting for application/service identification | `bool` | `true` | no |
| <a name="input_lan_network_name"></a> [lan\_network\_name](#input\_lan\_network\_name) | Name of the primary LAN network in UniFi UI | `string` | `"Default"` | no |
| <a name="input_lcd_monitor_brightness"></a> [lcd\_monitor\_brightness](#input\_lcd\_monitor\_brightness) | LCD display brightness level | `number` | `100` | no |
| <a name="input_lcd_monitor_enabled"></a> [lcd\_monitor\_enabled](#input\_lcd\_monitor\_enabled) | Enable LCD display on supported devices (e.g., UDM Pro, UNVR) | `bool` | `true` | no |
| <a name="input_lcd_monitor_idle_timeout"></a> [lcd\_monitor\_idle\_timeout](#input\_lcd\_monitor\_idle\_timeout) | Idle timeout in seconds before display turns off | `number` | `3600` | no |
| <a name="input_lcd_monitor_sync"></a> [lcd\_monitor\_sync](#input\_lcd\_monitor\_sync) | Synchronize display settings across multiple devices | `bool` | `true` | no |
| <a name="input_lcd_monitor_touch_event"></a> [lcd\_monitor\_touch\_event](#input\_lcd\_monitor\_touch\_event) | Enable touch interactions on the display | `bool` | `true` | no |
| <a name="input_led_enabled"></a> [led\_enabled](#input\_led\_enabled) | Enable status LEDs on devices | `bool` | `true` | no |
| <a name="input_magic_site_to_site_vpn_enabled"></a> [magic\_site\_to\_site\_vpn\_enabled](#input\_magic\_site\_to\_site\_vpn\_enabled) | Enable Magic Site-to-Site VPN functionality | `bool` | `false` | no |
| <a name="input_network_optimization_enabled"></a> [network\_optimization\_enabled](#input\_network\_optimization\_enabled) | Enable network optimization features (e.g., band steering, airtime fairness) | `bool` | `true` | no |
| <a name="input_ntp_mode"></a> [ntp\_mode](#input\_ntp\_mode) | NTP configuration mode ('auto' uses controller defaults; 'manual' requires servers) | `string` | `"manual"` | no |
| <a name="input_ntp_server_1"></a> [ntp\_server\_1](#input\_ntp\_server\_1) | Primary NTP server hostname or IP (required for 'manual' mode) | `string` | `"time.cloudflare.com"` | no |
| <a name="input_ntp_server_2"></a> [ntp\_server\_2](#input\_ntp\_server\_2) | Secondary NTP server hostname or IP | `string` | `"pool.ntp.org"` | no |
| <a name="input_ntp_server_3"></a> [ntp\_server\_3](#input\_ntp\_server\_3) | Tertiary NTP server hostname or IP | `string` | `"time.google.com"` | no |
| <a name="input_ntp_server_4"></a> [ntp\_server\_4](#input\_ntp\_server\_4) | Quaternary NTP server hostname or IP | `string` | `"0.pool.ntp.org"` | no |
| <a name="input_outdoor_mode_enabled"></a> [outdoor\_mode\_enabled](#input\_outdoor\_mode\_enabled) | Enable outdoor mode (affects some default behaviors) | `bool` | `false` | no |
| <a name="input_radius_accounting_enabled"></a> [radius\_accounting\_enabled](#input\_radius\_accounting\_enabled) | Enable RADIUS accounting for session tracking | `bool` | `true` | no |
| <a name="input_radius_accounting_port"></a> [radius\_accounting\_port](#input\_radius\_accounting\_port) | UDP port for RADIUS accounting | `number` | `1813` | no |
| <a name="input_radius_auth_port"></a> [radius\_auth\_port](#input\_radius\_auth\_port) | UDP port for RADIUS authentication | `number` | `1812` | no |
| <a name="input_radius_enabled"></a> [radius\_enabled](#input\_radius\_enabled) | Enable built-in RADIUS server functionality | `bool` | `false` | no |
| <a name="input_radius_interim_update_interval"></a> [radius\_interim\_update\_interval](#input\_radius\_interim\_update\_interval) | Interval (seconds) for RADIUS client statistic updates | `number` | `3600` | no |
| <a name="input_radius_secret"></a> [radius\_secret](#input\_radius\_secret) | Shared secret for RADIUS clients (use random\_password or secrets manager) | `string` | `""` | no |
| <a name="input_radius_tunneled_reply"></a> [radius\_tunneled\_reply](#input\_radius\_tunneled\_reply) | Enable encrypted RADIUS tunneling for added security | `bool` | `true` | no |
| <a name="input_ssh_auth_password_enabled"></a> [ssh\_auth\_password\_enabled](#input\_ssh\_auth\_password\_enabled) | Allow password authentication over SSH (less secure) | `bool` | `false` | no |
| <a name="input_ssh_bind_wildcard"></a> [ssh\_bind\_wildcard](#input\_ssh\_bind\_wildcard) | Bind SSH server to 0.0.0.0 instead of specific interfaces | `bool` | `false` | no |
| <a name="input_ssh_enabled"></a> [ssh\_enabled](#input\_ssh\_enabled) | Allow SSH access to devices managed by this controller (enable temporarily for security) | `bool` | `false` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | List of SSH public keys to authorize on devices (preferred over passwords) | <pre>list(object({<br/>    name    = string<br/>    type    = string # e.g., "ssh-rsa", "ssh-ed25519"<br/>    key     = string<br/>    comment = optional(string) # optional description/email<br/>  }))</pre> | `[]` | no |
| <a name="input_ssh_username"></a> [ssh\_username](#input\_ssh\_username) | Username for SSH access when password auth is enabled | `string` | `"admin"` | no |
| <a name="input_ssl_inspection_state"></a> [ssl\_inspection\_state](#input\_ssl\_inspection\_state) | SSL inspection mode ('off', 'simple', or 'advanced') | `string` | `"advanced"` | no |
| <a name="input_teleport_block_third_octet"></a> [teleport\_block\_third\_octet](#input\_teleport\_block\_third\_octet) | Third octet to use when carving the Teleport parent /24 block (default 100) | `number` | `100` | no |
| <a name="input_teleport_consumers"></a> [teleport\_consumers](#input\_teleport\_consumers) | Expected / planned number of Teleport clients (for documentation & capacity planning only — not enforced by UniFi/Terraform) | `number` | `100` | no |
| <a name="input_teleport_enabled"></a> [teleport\_enabled](#input\_teleport\_enabled) | Enable Teleport remote access functionality | `bool` | `false` | no |
| <a name="input_teleport_subnet"></a> [teleport\_subnet](#input\_teleport\_subnet) | CIDR subnet for Teleport VPN clients (e.g., '192.168.100.0/24'); set to 'auto' for automatic calculation based on expected consumers | `string` | `"auto"` | no |
| <a name="input_unifi_allow_insecure"></a> [unifi\_allow\_insecure](#input\_unifi\_allow\_insecure) | Allow self-signed/invalid certificates | `bool` | `true` | no |
| <a name="input_unifi_api_url"></a> [unifi\_api\_url](#input\_unifi\_api\_url) | Base URL of your UniFi controller (no trailing /api) | `string` | `"https://192.168.1.1"` | no |
| <a name="input_unifi_idp_enabled"></a> [unifi\_idp\_enabled](#input\_unifi\_idp\_enabled) | Enable UniFi Identity Provider integration | `bool` | `false` | no |
| <a name="input_unifi_site"></a> [unifi\_site](#input\_unifi\_site) | Site name ('default' in most single-site setups) | `string` | `"default"` | no |
| <a name="input_usw_dhcp_snoop"></a> [usw\_dhcp\_snoop](#input\_usw\_dhcp\_snoop) | Enable DHCP snooping to protect against rogue DHCP servers | `bool` | `true` | no |
| <a name="input_wifiman_enabled"></a> [wifiman\_enabled](#input\_wifiman\_enabled) | Enable WiFiman integration/telemetry | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the applied management settings object (from unifi\_setting\_mgmt resource) |
| <a name="output_rfc1918_compliant"></a> [rfc1918\_compliant](#output\_rfc1918\_compliant) | Whether the LAN subnet falls within a valid RFC 1918 private address range (true/false) |
| <a name="output_site_cidr"></a> [site\_cidr](#output\_site\_cidr) | The fallback private supernet CIDR block used for address space calculations (derived from RFC 1918 classification) |
| <a name="output_site_class"></a> [site\_class](#output\_site\_class) | Detected address class of the LAN subnet (A (private), B (private), C (private), D (multicast), E (reserved), or other) |
| <a name="output_site_magic_enabled"></a> [site\_magic\_enabled](#output\_site\_magic\_enabled) | Whether Magic Site-to-Site VPN is enabled on this site |
| <a name="output_site_radius_enabled"></a> [site\_radius\_enabled](#output\_site\_radius\_enabled) | Whether the built-in RADIUS server is enabled on this site |
| <a name="output_site_ssh_enabled"></a> [site\_ssh\_enabled](#output\_site\_ssh\_enabled) | Whether SSH access to managed devices is enabled (from management settings) |
| <a name="output_site_teleport_enabled"></a> [site\_teleport\_enabled](#output\_site\_teleport\_enabled) | Whether Teleport VPN is enabled on this site |

## Usage

Basic example with mostly defaults and Teleport auto-enabled:

```hcl
module "unifi_site_basics" {
  source = "git::https://github.com/BrainXio/unifi-site-basics.git?ref=next"  # or local path / registry

  # Required if your primary LAN is not named "Default"
  lan_network_name = "Default"

  # Core toggles – enable what you need
  teleport_enabled       = true
  teleport_subnet        = "auto"           # auto-calculates from .100 block
  teleport_consumers     = 25               # influences auto subnet size
  teleport_block_third_octet = 100          # default – change if you want e.g. .200

  radius_enabled         = true             # auto-generates secret if not provided
  magic_site_to_site_vpn_enabled = false

  # Optional overrides / examples
  ssh_enabled            = true
  ssh_username           = "rootadmin"
  # ssh_keys             = [ { name = "my-laptop", type = "ssh-ed25519", key = "..." } ]

  ntp_mode               = "manual"
  ntp_server_1           = "time.mydomain.net"

  # Most other features are enabled by default – disable if unwanted
  auto_upgrade           = false
  wifiman_enabled        = false
}
```

### Minimal / testing example (almost everything off)

```hcl
module "unifi_site_basics" {
  source = "./basic-config"  # or git source

  lan_network_name = "Default"

  # Only apply bare minimum
  teleport_enabled   = false
  radius_enabled     = false
  magic_site_to_site_vpn_enabled = false
}
```

### Important notes for usage

- **Teleport subnet**:
  - `"auto"` → carves smallest reasonable subnet from `192.168.100.0/24` (or equivalent in 10.x/172.16.x) based on `teleport_consumers`
  - Manual: set `teleport_subnet = "192.168.200.0/27"` directly
  - Change block with `teleport_block_third_octet = 150` → uses 192.168.150.0/24 instead

- **RADIUS secret**:
  - Provide `radius_secret` yourself, or leave empty → module generates a strong random one

- **SSH**:
  - Prefer `ssh_keys` list over password auth for security
  - `ssh_enabled = true` is temporary — UniFi recommends disabling when not needed

- **Site detection**:
  - Uses `data "unifi_network"` on the network named `lan_network_name` to derive site and classify address space

Apply with:

```bash
tofu init
tofu plan
tofu apply
```

All features can be toggled independently — defaults aim for "sensible & secure" out of the box.

---

<p align="center" style="font-size: 1.1em; font-style: italic;">
"Embrace the broken branch; from its fall grows the stronger trunk." | Another Intelligence
</p>

<p align="center">
  <a href="https://github.com/BrainXio/unifi-site-basics/issues/new?template=bug.md">Report bug</a>
  ·
  <a href="https://github.com/BrainXio/unifi-site-basics/issues/new?template=feature.md&labels=feature">Request feature</a>
</p>

<p align="center" style="font-size: 0.9em; color: #666;">
  Generated on 2026-02-05 23:27:22 UTC
</p>
<!-- END_TF_DOCS -->