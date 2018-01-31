# Class: prometheus
#
# This module manages prometheus
#
# Parameters:
#
#  [*manage_user*]
#  Whether to create user for prometheus or rely on external code for that
#
#  [*user*]
#  User running prometheus
#
#  [*manage_group*]
#  Whether to create user for prometheus or rely on external code for that
#
#  [*purge_config_dir*]
#  Purge config files no longer generated by Puppet
#
#  [*group*]
#  Group under which prometheus is running
#
#  [*bin_dir*]
#  Directory where binaries are located
#
#  [*shared_dir*]
#  Directory where shared files are located
#
#  [*arch*]
#  Architecture (amd64 or i386)
#
#  [*version*]
#  Prometheus release
#
#  [*install_method*]
#  Installation method: url or package (only url is supported currently)
#
#  [*os*]
#  Operating system (linux is supported)
#
#  [*download_url*]
#  Complete URL corresponding to the Prometheus release, default to undef
#
#  [*download_url_base*]
#  Base URL for prometheus
#
#  [*download_extension*]
#  Extension of Prometheus binaries archive
#
#  [*package_name*]
#  Prometheus package name - not available yet
#
#  [*package_ensure*]
#  If package, then use this for package ensurel default 'latest'
#
#  [*config_dir*]
#  Prometheus configuration directory (default /etc/prometheus)
#
#  [*localstorage*]
#  Location of prometheus local storage (storage.local argument)
#
#  [*extra_options*]
#  Extra options added to prometheus startup command
#
#  [*config_hash*]
#  Startup config hash
#
#  [*config_defaults*]
#  Startup config defaults
#
#  [*config_template*]
#  Configuration template to use (template/prometheus.yaml.erb)
#
#  [*config_mode*]
#  Configuration file mode (default 0660)
#
#  [*service_enable*]
#  Whether to enable or not prometheus service from puppet (default true)
#
#  [*service_ensure*]
#  State ensured from prometheus service (default 'running')
#
#  [*manage_service*]
#  Should puppet manage the prometheus service? (default true)
#
#  [*restart_on_change*]
#  Should puppet restart prometheus on configuration change? (default true)
#  Note: this applies only to command-line options changes. Configuration
#  options are always *reloaded* without restarting.
#
#  [*init_style*]
#  Service startup scripts style (e.g. rc, upstart or systemd)
#
#  [*global_config*]
#  Prometheus global configuration variables
#
#  [*rule_files*]
#  Prometheus rule files
#
#  [*scrape_configs*]
#  Prometheus scrape configs
#
#  [*remote_read_configs*]
#  Prometheus remote_read config to scrape prometheus 1.8+ instances
#
#  [*remote_write_configs*]
#  Prometheus remote_write config to scrape prometheus 1.8+ instances
#
#  [*alert_relabel_config*]
#  Prometheus alert relabel config under alerting
#
#  [*alertmanagers_config*]
#  Prometheus managers config under alerting
#
#  [*storage_retention*]
#  How long to keep timeseries data. This is given as a duration like "100h" or "14d". Until
#  prometheus 1.8.*, only durations understood by golang's time.ParseDuration are supported. Starting
#  with prometheus 2, durations can also be given in days, weeks and years.
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class prometheus (
  Boolean $manage_user        = true,
  $user                       = $::prometheus::params::user,
  $manage_group               = true,
  Boolean $purge_config_dir   = true,
  $group                      = $::prometheus::params::group,
  $extra_groups               = $::prometheus::params::extra_groups,
  $bin_dir                    = $::prometheus::params::bin_dir,
  $shared_dir                 = $::prometheus::params::shared_dir,
  $arch                       = $::prometheus::params::arch,
  $version                    = $::prometheus::params::version,
  $install_method             = $::prometheus::params::install_method,
  $os                         = $::prometheus::params::os,
  $download_url               = undef,
  $download_url_base          = $::prometheus::params::download_url_base,
  $download_extension         = $::prometheus::params::download_extension,
  $package_name               = $::prometheus::params::package_name,
  $package_ensure             = $::prometheus::params::package_ensure,
  String $config_dir          = $::prometheus::params::config_dir,
  $localstorage               = $::prometheus::params::localstorage,
  $extra_options              = '',
  Hash $config_hash           = {},
  Hash $config_defaults       = {},
  $config_template            = $::prometheus::params::config_template,
  $config_mode                = $::prometheus::params::config_mode,
  $service_enable             = true,
  $service_ensure             = 'running',
  Boolean $manage_service     = true,
  Boolean $restart_on_change  = true,
  $init_style                 = $::prometheus::params::init_style,
  Hash $global_config         = $::prometheus::params::global_config,
  Array $rule_files           = $::prometheus::params::rule_files,
  Array $scrape_configs       = $::prometheus::params::scrape_configs,
  Array $remote_read_configs  = $::prometheus::params::remote_read_configs,
  Array $remote_write_configs = $::prometheus::params::remote_write_configs,
  $alerts                     = $::prometheus::params::alerts,
  Array $alert_relabel_config = $::prometheus::params::alert_relabel_config,
  Array $alertmanagers_config = $::prometheus::params::alertmanagers_config,
  String $storage_retention   = $::prometheus::params::storage_retention,
) inherits prometheus::params {

  if( versioncmp($::prometheus::version, '1.0.0') == -1 ){
    $real_download_url = pick($download_url,
      "${download_url_base}/download/${version}/${package_name}-${version}.${os}-${arch}.${download_extension}")
  } else {
    $real_download_url = pick($download_url,
      "${download_url_base}/download/v${version}/${package_name}-${version}.${os}-${arch}.${download_extension}")
  }
  $notify_service = $restart_on_change ? {
    true    => Service['prometheus'],
    default => undef,
  }


  $config_hash_real = assert_type(Hash, deep_merge($config_defaults, $config_hash))

  anchor {'prometheus_first': }
  -> class { '::prometheus::install':
    purge_config_dir => $purge_config_dir,
  }
  -> class { '::prometheus::alerts':
    location => $config_dir,
    alerts   => $alerts,
  }
  -> class { '::prometheus::config':
    global_config        => $global_config,
    rule_files           => $rule_files,
    scrape_configs       => $scrape_configs,
    remote_read_configs  => $remote_read_configs,
    remote_write_configs => $remote_write_configs,
    config_template      => $config_template,
    storage_retention    => $storage_retention,
  }
  -> class { '::prometheus::run_service': }
  -> class { '::prometheus::service_reload': }
  -> anchor {'prometheus_last': }
}
