# Class: prometheus::pushgateway
#
# This module manages prometheus node pushgateway
#
# Parameters:
#  [*arch*]
#  Architecture (amd64 or i386)

#  [*bin_dir*]
#  Directory where binaries are located
#
#  [*download_extension*]
#  Extension for the release binary archive
#
#  [*download_url*]
#  Complete URL corresponding to the where the release binary archive can be downloaded
#
#  [*download_url_base*]
#  Base URL for the binary archive
#
#  [*extra_groups*]
#  Extra groups to add the binary user to
#
#  [*extra_options*]
#  Extra options added to the startup command
#
#  [*group*]
#  Group under which the binary is running
#
#  [*init_style*]
#  Service startup scripts style (e.g. rc, upstart or systemd)
#
#  [*install_method*]
#  Installation method: url or package (only url is supported currently)
#
#  [*manage_group*]
#  Whether to create a group for or rely on external code for that
#
#  [*manage_service*]
#  Should puppet manage the service? (default true)
#
#  [*manage_user*]
#  Whether to create user or rely on external code for that
#
#  [*os*]
#  Operating system (linux is the only one supported)
#
#  [*package_ensure*]
#  If package, then use this for package ensure default 'latest'
#
#  [*package_name*]
#  The binary package name - not available yet
#
#  [*restart_on_change*]
#  Should puppet restart the service on configuration change? (default true)
#
#  [*service_enable*]
#  Whether to enable the service from puppet (default true)
#
#  [*service_ensure*]
#  State ensured for the service (default 'running')
#
#  [*service_name*]
#  Name of the node exporter service (default 'pushgateway')
#
#  [*user*]
#  User which runs the service
#
#  [*version*]
#  The binary release version
class prometheus::pushgateway (
  $arch                 = $::prometheus::params::arch,
  $bin_dir              = $::prometheus::params::bin_dir,
  $download_extension   = $::prometheus::params::pushgateway_download_extension,
  $download_url         = undef,
  $download_url_base    = $::prometheus::params::pushgateway_download_url_base,
  $extra_groups         = $::prometheus::params::pushgateway_extra_groups,
  $extra_options        = '',
  $group                = $::prometheus::params::pushgateway_group,
  $init_style           = $::prometheus::params::init_style,
  $install_method       = $::prometheus::params::install_method,
  $manage_group         = true,
  $manage_service       = true,
  $manage_user          = true,
  $os                   = $::prometheus::params::os,
  $package_ensure       = $::prometheus::params::pushgateway_package_ensure,
  $package_name         = $::prometheus::params::pushgateway_package_name,
  $restart_on_change    = true,
  $service_enable       = true,
  $service_ensure       = 'running',
  $service_name         = 'pushgateway',
  $user                 = $::prometheus::params::pushgateway_user,
  $version              = $::prometheus::params::pushgateway_version,
) inherits prometheus::params {
  # Prometheus added a 'v' on the realease name at 0.13.0
  if versioncmp ($version, '0.3.0') >= 0 {
    $release = "v${version}"
  }
  else {
    $release = $version
  }
  $real_download_url = pick($download_url,"${download_url_base}/download/${release}/${package_name}-${version}.${os}-${arch}.${download_extension}")
  validate_bool($manage_user)
  validate_bool($manage_service)
  validate_bool($restart_on_change)
  $notify_service = $restart_on_change ? {
    true    => Service[$service_name],
    default => undef,
  }

  prometheus::daemon { $service_name :
    install_method     => $install_method,
    version            => $version,
    download_extension => $download_extension,
    os                 => $os,
    arch               => $arch,
    real_download_url  => $real_download_url,
    bin_dir            => $bin_dir,
    notify_service     => $notify_service,
    package_name       => $package_name,
    package_ensure     => $package_ensure,
    manage_user        => $manage_user,
    user               => $user,
    extra_groups       => $extra_groups,
    group              => $group,
    manage_group       => $manage_group,
    options            => $options,
    init_style         => $init_style,
    service_ensure     => $service_ensure,
    service_enable     => $service_enable,
    manage_service     => $manage_service,
  }
}
