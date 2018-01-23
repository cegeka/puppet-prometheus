# Class: prometheus::alerts
#
# This module manages prometheus alerts for prometheus
#
#  [*location*]
#  Where to create the alert file for prometheus
#
#  [*alerts*]
#  Array (< prometheus 2.0.0) or Hash (>= prometheus 2.0.0) of alerts (see README).
#
#  [*alertfile_name*]
#  Filename to use when storing the alerts file
#
class prometheus::alerts (
  String $location,
  Variant[Array,Hash] $alerts,
  String $alertfile_name = $prometheus::params::alertfile_name,
) inherits prometheus::params {
  if ( versioncmp($::prometheus::version, '2.0.0') < 0 ){
    file { "${location}/${alertfile_name}":
      ensure       => 'file',
      owner        => $prometheus::user,
      group        => $prometheus::group,
      notify       => Class['::prometheus::service_reload'],
      content      => epp("${module_name}/alerts.epp"),
      validate_cmd => "${prometheus::bin_dir}/promtool check-rules %",
    }
  }
  else {
    file { "${location}/${alertfile_name}":
      ensure       => 'file',
      owner        => $prometheus::user,
      group        => $prometheus::group,
      notify       => Class['::prometheus::service_reload'],
      content      => $alerts.to_yaml,
      validate_cmd => "${prometheus::bin_dir}/promtool check rules %",
    }
  }
}
