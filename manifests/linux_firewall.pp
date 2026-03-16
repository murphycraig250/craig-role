# Configures Linux firewall settings
#
# This role applies firewall configurations by including pre, rules, and post profiles.
#
# @summary Linux firewall configuration role
class role::linux_firewall {
  include profile::linux_firewall::post
  include profile::linux_firewall::pre
  include profile::linux_firewall::rules

  Class['profile::linux_firewall::pre']
  -> Class['profile::linux_firewall::rules']
  -> Class['profile::linux_firewall::post']

# 1. Purge the INPUT chain (Host Security)
  firewallchain { 'INPUT:filter:IPv4':
    purge => true,
  }

  # 2. Purge the FORWARD chain but ignore Docker's bridges
  firewallchain { 'FORWARD:filter:IPv4':
    purge  => true,
    ignore => [
      'DOCKER-USER',
      'DOCKER-FORWARD',
      'DOCKER-ISOLATION',
    ],
  }

  # 3. Protect Docker's internal filter chains from being emptied
  firewallchain { [
      'DOCKER:filter:IPv4',
      'DOCKER-BRIDGE:filter:IPv4',
      'DOCKER-CT:filter:IPv4',
      'DOCKER-FORWARD:filter:IPv4',
      'DOCKER-INTERNAL:filter:IPv4',
      'DOCKER-USER:filter:IPv4',
    ]:
      purge => false,
  }

  # 4. Protect the NAT table (Vital for Container Internet/Port Mapping)
  firewallchain { [
      'PREROUTING:nat:IPv4',
      'INPUT:nat:IPv4',
      'OUTPUT:nat:IPv4',
      'POSTROUTING:nat:IPv4',
      'DOCKER:nat:IPv4',
    ]:
      purge => false,
  }
}
