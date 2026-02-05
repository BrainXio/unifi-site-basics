## Usage

Basic example with mostly defaults and Teleport auto-enabled:

```hcl
module "unifi_site_basics" {
  source = "git::https://github.com/${GITHUB_REPOSITORY}.git?ref=${REF}"  # or local path / registry

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
  <a href="https://github.com/${GITHUB_REPOSITORY}/issues/new?template=bug.md">Report bug</a>
  ·
  <a href="https://github.com/${GITHUB_REPOSITORY}/issues/new?template=feature.md&labels=feature">Request feature</a>
</p>

<p align="center" style="font-size: 0.9em; color: #666;">
  Generated on ${GENERATION_TIMESTAMP}
</p>
