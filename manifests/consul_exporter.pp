# Class: prometheus::consul_exporter
#
# This module manages prometheus node consul_exporter
#
# Parameters:
#  [*arch*]
#  Architecture (amd64 or i386)
#
#  [*bin_dir*]
#  Directory where binaries are located
#
#  [*consul_server*]
#  HTTP API address of a Consul server or agent. (prefix with https:// to connect over HTTPS) (default "http://localhost:8500")
#
#  [*consul_health_summary*]
#  Generate a health summary for each service instance. Needs n+1 queries to collect all information. (default true)
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
#  [*log_level*]
#  Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal] (default "info")
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
#  [*purge_config_dir*]
#  Purge config files no longer generated by Puppet
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
#  [*user*]
#  User which runs the service
#
#  [*version*]
#  The binary release version
#
#  [*web_listen_address*]
#  Address to listen on for web interface and telemetry. (default ":9107")
#
#  [*web_telemetry_path*]
#  Path under which to expose metrics. (default "/metrics")

class prometheus::consul_exporter (
  String $arch                   = $prometheus::arch,
  String $bin_dir                = $prometheus::bin_dir,
  Boolean $consul_health_summary,
  String $consul_server,
  String $download_extension,
  Optional[String] $download_url = undef,
  String $download_url_base,
  Array $extra_groups,
  String $extra_options          = '',
  String $group,
  String $init_style             = $prometheus::init_style,
  String $install_method         = $prometheus::install_method,
  String $log_level,
  Boolean $manage_group          = true,
  Boolean $manage_service        = true,
  Boolean $manage_user           = true,
  String $os                     = $prometheus::os,
  String $package_ensure,
  String $package_name,
  Boolean $purge_config_dir      = true,
  Boolean $restart_on_change     = true,
  Boolean $service_enable        = true,
  String $service_ensure         = 'running',
  String $user,
  String $version,
  String $web_listen_address,
  String $web_telemetry_path,
) inherits prometheus {

  # Prometheus added a 'v' on the realease name at 0.3.0
  if versioncmp ($version, '0.3.0') == -1 {
    fail("I only support consul_exporter version '0.3.0' or higher")
  }

  $real_download_url = pick($download_url,"${download_url_base}/download/v${version}/${package_name}-${version}.${os}-${arch}.${download_extension}")

  if $consul_health_summary {
    $real_consul_health_summary = '-consul.health-summary'
  } else {
    $real_consul_health_summary = ''
  }

  $notify_service = $restart_on_change ? {
    true    => Service['consul_exporter'],
    default => undef,
  }

  $options = "-consul.server=${consul_server} ${real_consul_health_summary} -web.listen-address=${web_listen_address} -web.telemetry-path=${web_telemetry_path} -log.level=${log_level} ${extra_options}"

  prometheus::daemon { 'consul_exporter':
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
    purge              => $purge_config_dir,
    options            => $options,
    init_style         => $init_style,
    service_ensure     => $service_ensure,
    service_enable     => $service_enable,
    manage_service     => $manage_service,
  }
}
