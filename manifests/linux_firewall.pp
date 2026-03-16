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

  # The Global Purge
  resources { 'firewall':
    purge => true,
  }

  # 1. Protect the Docker chain definitions
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

  # 2. Tell the FORWARD chain specifically what to ignore
  firewallchain { 'FORWARD:filter:IPv4':
    purge  => true,
    ignore => [
      'DOCKER-USER',
      'DOCKER-FORWARD',
    ],
  }
}
