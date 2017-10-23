# Class: prometheus::mysqld_exporter
#
# This module manages prometheus mysqld_exporter
#
# Parameters:
#  [*arch*]
#  Architecture (amd64 or i386)
#
#  [*bin_dir*]
#  Directory where binaries are located
#
#  [*cnf_config_path*]
#  The path to put the my.cnf file
#
#  [*cnf_host*]
#  The mysql host. Defaults to 'localhost'
#
#  [*cnf_password*]
#  The mysql user password. Defaults to 'password'
#
#  [*cnf_port*]
#  The port for which the mysql host is running. Defaults to 3306
#
#  [*cnf_socket*]
#  The socket which the mysql host is running. If defined, host and port are not used.
#
#  [*cnf_user*]
#  The mysql user to use when connecting. Defaults to 'login'
#
#  [*config_mode*]
#  The permissions of the configuration files
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
class prometheus::mysqld_exporter (
  $arch                      = $::prometheus::params::arch,
  $bin_dir                   = $::prometheus::params::bin_dir,
  $cnf_config_path           = $::prometheus::params::mysqld_exporter_cnf_config_path,
  $cnf_host                  = $::prometheus::params::mysqld_exporter_cnf_host,
  $cnf_password              = $::prometheus::params::mysqld_exporter_cnf_password,
  $cnf_port                  = $::prometheus::params::mysqld_exporter_cnf_port,
  $cnf_socket                = undef,
  $cnf_user                  = $::prometheus::params::mysqld_exporter_cnf_user,
  $config_mode               = $::prometheus::params::config_mode,
  $download_extension        = $::prometheus::params::mysqld_exporter_download_extension,
  $download_url              = undef,
  $download_url_base         = $::prometheus::params::mysqld_exporter_download_url_base,
  $extra_groups              = $::prometheus::params::mysqld_exporter_extra_groups,
  $extra_options             = '',
  $group                     = $::prometheus::params::mysqld_exporter_group,
  $init_style                = $::prometheus::params::init_style,
  $install_method            = $::prometheus::params::install_method,
  Boolean $manage_group      = true,
  Boolean $manage_service    = true,
  Boolean $manage_user       = true,
  $os                        = $::prometheus::params::os,
  $package_ensure            = $::prometheus::params::mysqld_exporter_package_ensure,
  $package_name              = $::prometheus::params::mysqld_exporter_package_name,
  Boolean $purge_config_dir  = true,
  Boolean $restart_on_change = true,
  Boolean $service_enable    = true,
  $service_ensure            = 'running',
  $user                      = $::prometheus::params::mysqld_exporter_user,
  $version                   = $::prometheus::params::mysqld_exporter_version,
) inherits prometheus::params {

  #Please provide the download_url for versions < 0.9.0
  $real_download_url    = pick($download_url,"${download_url_base}/download/v${version}/${package_name}-${version}.${os}-${arch}.${download_extension}")
  $notify_service = $restart_on_change ? {
    true    => Service['mysqld_exporter'],
    default => undef,
  }

  file { $cnf_config_path:
    ensure  => 'file',
    mode    => $config_mode,
    owner   => $user,
    group   => $group,
    content => template('prometheus/my.cnf.erb'),
    notify  => $notify_service,
  }

  $options = "-config.my-cnf=${cnf_config_path} ${extra_options}"

  prometheus::daemon { 'mysqld_exporter':
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
