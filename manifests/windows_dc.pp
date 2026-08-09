# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::windows_dc
class role::windows_dc {
  include profile::choco_setup
  include profile::choco_windows
  include profile::dc_features
  include profile::dc_promotion
  include profile::dc_network
  include profile::dc_ous
  include profile::dc_groups

  Class['profile::choco_setup']
  -> Class['profile::choco_windows']
  -> Class['profile::dc_network']
  -> Class['profile::dc_features']
  -> Class['profile::dc_promotion']
  -> Class['profile::dc_ous']
  -> Class['profile::dc_groups']
}
