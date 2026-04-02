# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::windows_dc
class role::windows_dc {
  include profile::base_windows
  include profile::choco_windows
  include profile::windows_dc_setup
  include profile::windows_dc_features

  Class['profile::base_windows']
  -> Class['profile::windows_dc_setup']
  -> Class['profile::windows_dc_features']
  -> Class['profile::choco_windows']
}
