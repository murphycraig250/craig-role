# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::windows_dc
class role::windows_dc {
  include profile::choco_setup
  include profile::choco_windows
  include profile::windows_dc_features
}
