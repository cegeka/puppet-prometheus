# Class prometheus::node_exporter::install
# Install prometheus node node_exporter via different methods with parameters from init
# Currently only the install from url is implemented, when Prometheus will deliver packages for some Linux distros I will
# implement the package install method as well
# The package method needs specific yum or apt repo settings which are not made yet by the module
class prometheus::node_exporter::install
{

  case $::prometheus::node_exporter::install_method {
    'url': {
      include staging
      $staging_file = "node_exporter-${prometheus::node_exporter::version}.${prometheus::node_exporter::download_extension}"
      if( versioncmp($::prometheus::node_exporter::version, '0.12.0') == -1 ){
        $binary = "${::staging::path}/node_exporter"
      } else {
          $binary = "${::staging::path}/node_exporter-${::prometheus::node_exporter::version}.${::prometheus::node_exporter::os}-${::prometheus::node_exporter::arch}/node_exporter"
      }
      staging::file { $staging_file:
        source => $prometheus::node_exporter::real_download_url,
      } ->
      staging::extract { $staging_file:
        target  => $::staging::path,
        creates => $binary,
      } ->
      file {
        $binary:
          owner => 'root',
          group => 0, # 0 instead of root because OS X uses "wheel".
          mode  => '0555';
        "${::prometheus::node_exporter::bin_dir}/node_exporter":
          ensure => link,
          notify => $::prometheus::node_exporter::notify_service,
          target => $binary,
      }
    }
    'package': {
      package { $::prometheus::node_exporter::package_name:
        ensure => $::prometheus::node_exporter::package_ensure,
      }
      if $::prometheus::node_exporter::manage_user {
        User[$::prometheus::node_exporter::user] -> Package[$::prometheus::node_exporter::package_name]
      }
    }
    'none': {}
    default: {
      fail("The provided install method ${::prometheus::install_method} is invalid")
    }
  }
  if $::prometheus::node_exporter::manage_user {
    ensure_resource('user', [ $::prometheus::node_exporter::user ], {
      ensure => 'present',
      system => true,
      groups => $::prometheus::node_exporter::extra_groups,
    })

    if $::prometheus::node_exporter::manage_group {
      Group[$::prometheus::node_exporter::group] -> User[$::prometheus::node_exporter::user]
    }
  }
  if $::prometheus::node_exporter::manage_group {
    ensure_resource('group', [ $::prometheus::node_exporter::group ], {
      ensure => 'present',
      system => true,
    })
  }
}
