# @summary This module manages prometheus node node_exporter
# @param arch
#  Architecture (amd64 or i386)
# @param bin_dir
#  Directory where binaries are located
# @param collectors
#  deprecated, unused kept for migration scenatrios
#  will be removed in next release
# @param collectors_enable
#  Collectors to enable, addtionally to the defaults
#  https://github.com/prometheus/node_exporter#enabled-by-default
# @param collectors_disable
#  disable collectors which are enabled by default
#  https://github.com/prometheus/node_exporter#enabled-by-default
# @param download_extension
#  Extension for the release binary archive
# @param download_url
#  Complete URL corresponding to the where the release binary archive can be downloaded
# @param download_url_base
#  Base URL for the binary archive
# @param extra_groups
#  Extra groups to add the binary user to
# @param extra_options
#  Extra options added to the startup command
# @param group
#  Group under which the binary is running
# @param init_style
#  Service startup scripts style (e.g. rc, upstart or systemd)
# @param install_method
#  Installation method: url or package (only url is supported currently)
# @param manage_group
#  Whether to create a group for or rely on external code for that
# @param manage_service
#  Should puppet manage the service? (default true)
# @param manage_user
#  Whether to create user or rely on external code for that
# @param os
#  Operating system (linux is the only one supported)
# @param package_ensure
#  If package, then use this for package ensure default 'latest'
# @param package_name
#  The binary package name - not available yet
# @param purge_config_dir
#  Purge config files no longer generated by Puppet
# @param restart_on_change
#  Should puppet restart the service on configuration change? (default true)
# @param service_enable
#  Whether to enable the service from puppet (default true)
# @param service_ensure
#  State ensured for the service (default 'running')
# @param service_name
#  Name of the node exporter service (default 'node_exporter')
# @param user
#  User which runs the service
# @param version
#  The binary release version
class prometheus::node_exporter (
  String $download_extension,
  String $download_url_base,
  Array[String] $extra_groups,
  String $group,
  String $package_ensure,
  String $package_name,
  String $user,
  String $version,
  Boolean $purge_config_dir           = true,
  Boolean $restart_on_change          = true,
  Boolean $service_enable             = true,
  String $service_ensure              = 'running',
  String $service_name                = 'node_exporter',
  Optional[String] $init_style        = $prometheus::init_style,
  String $install_method              = $prometheus::install_method,
  Boolean $manage_group               = true,
  Boolean $manage_service             = true,
  Boolean $manage_user                = true,
  String $os                          = $prometheus::os,
  String $extra_options               = '',
  Optional[String] $download_url      = undef,
  String $arch                        = $prometheus::real_arch,
  String $bin_dir                     = $prometheus::bin_dir,
  Optional[Array[String]] $collectors = undef,
  Array[String] $collectors_enable    = [],
  Array[String] $collectors_disable   = [],
  Boolean $export_scrape_job          = false,
  Stdlib::Port $scrape_port           = 9100,
  String[1] $scrape_job_name          = 'node',
  Optional[Hash] $scrape_job_labels   = undef,
  Optional[String[1]] $bin_name       = undef,
) inherits prometheus {

  # Prometheus added a 'v' on the realease name at 0.13.0
  if versioncmp ($version, '0.13.0') >= 0 {
    $release = "v${version}"
  }
  else {
    $release = $version
  }
  $real_download_url = pick($download_url,"${download_url_base}/download/${release}/${package_name}-${version}.${os}-${arch}.${download_extension}")
  if $collectors {
    warning('Use of $collectors parameter is deprecated')
  }

  $notify_service = $restart_on_change ? {
    true    => Service[$service_name],
    default => undef,
  }

  $cmd_collectors_enable = $collectors_enable.map |$collector| {
    "--collector.${collector}"
  }

  $cmd_collectors_disable = $collectors_disable.map |$collector| {
    "--no-collector.${collector}"
  }


    $options = join([$extra_options,
      join($cmd_collectors_enable, ' '),
      join($cmd_collectors_disable, ' ') ], ' ')

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
    purge              => $purge_config_dir,
    options            => $options,
    init_style         => $init_style,
    service_ensure     => $service_ensure,
    service_enable     => $service_enable,
    manage_service     => $manage_service,
    export_scrape_job  => $export_scrape_job,
    scrape_port        => $scrape_port,
    scrape_job_name    => $scrape_job_name,
    scrape_job_labels  => $scrape_job_labels,
    bin_name           => $bin_name,
  }
}
