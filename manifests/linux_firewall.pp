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

  firewallchain { 'INPUT:filter:IPv4':
    purge => true,
  }

# 2. Manage the FORWARD chain but ignore Docker's jumps
  firewallchain { 'FORWARD:filter:IPv4':
    purge  => true,
    ignore => [
      'DOCKER-USER',
      'DOCKER-FORWARD',
      'DOCKER-ISOLATION', # Added this just in case
    ],
  }

# 3. Explicitly tell Puppet to leave the NAT table alone
  firewallchain { [
      'PREROUTING:nat:IPv4',
      'POSTROUTING:nat:IPv4',
      'OUTPUT:nat:IPv4',
      'DOCKER:nat:IPv4',
    ]:
      purge => false,
  }
