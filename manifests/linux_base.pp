# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::linux_base
class role::linux_base {
  include profile::base_linux
  #include profile::apache
  include profile::linux_motd
  include profile::linux_user
  include profile::linux_cron
  include profile::linux_packages
  if lookup('profile::linux_nfsserver::enabled', Boolean, 'first', false) {
    include profile::linux_nfsserver
  }
  if lookup('profile::linux_nfsclient::enabled', Boolean, 'first', false) {
    include profile::linux_nfsclient
  }
  if lookup('profile::linux_nginx::enabled', Boolean, 'first', false) {
    include profile::linux_nginx
  }
}
