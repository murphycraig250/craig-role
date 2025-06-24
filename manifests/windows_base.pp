# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::windows_base
class role::windows_base {
  include profile::base_windows
  include profile::choco_windows
}
