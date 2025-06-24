# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::linux_base
class role::linux_base {
  include profile::base_linux
  include profile::apache
}
