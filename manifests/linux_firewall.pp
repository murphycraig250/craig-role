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
}
