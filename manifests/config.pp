# Class prometheus::config
# Configuration class for prometheus monitoring system
class prometheus::config (
  Hash $global_config,
  Array $rule_files,
  Array $scrape_configs,
  Array $remote_read_configs,
  Array $remote_write_configs,
  String $config_template = $::prometheus::params::config_template,
  String $storage_retention = $::prometheus::params::storage_retention,
) {

  if $prometheus::init_style {
    if( versioncmp($::prometheus::version, '2.0.0') < 0 ){
      # helper variable indicating prometheus version, so we can use on this information in the template
      $prometheus_v2 = false
      if $remote_read_configs != [] {
        fail('remote_read_configs requires prometheus 2.X')
      }
      if $remote_write_configs != [] {
        fail('remote_write_configs requires prometheus 2.X')
      }
      $daemon_flags = [
        "-config.file=${::prometheus::config_dir}/prometheus.yaml",
        "-storage.local.path=${::prometheus::localstorage}",
        "-storage.local.retention=${storage_retention}",
        "-web.console.templates=${::prometheus::shared_dir}/consoles",
        "-web.console.libraries=${::prometheus::shared_dir}/console_libraries",
      ]
    } else {
      # helper variable indicating prometheus version, so we can use on this information in the template
      $prometheus_v2 = true
      $daemon_flags = [
        "--config.file=${::prometheus::config_dir}/prometheus.yaml",
        "--storage.tsdb.path=${::prometheus::localstorage}",
        "--storage.tsdb.retention=${storage_retention}",
        "--web.console.templates=${::prometheus::shared_dir}/consoles",
        "--web.console.libraries=${::prometheus::shared_dir}/console_libraries",
      ]
    }

    # the vast majority of files here are init-files
    # so any change there should trigger a full service restart
    if $::prometheus::restart_on_change {
      File {
        notify => [Class['::prometheus::run_service']],
      }
      $systemd_notify = [Exec['prometheus-systemd-reload'], Class['::prometheus::run_service']]
    } else {
      $systemd_notify = Exec['prometheus-systemd-reload']
    }

    case $prometheus::init_style {
      'upstart' : {
        file { '/etc/init/prometheus.conf':
          mode    => '0444',
          owner   => 'root',
          group   => 'root',
          content => template('prometheus/prometheus.upstart.erb'),
        }
        file { '/etc/init.d/prometheus':
          ensure => link,
          target => '/lib/init/upstart-job',
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        }
      }
      'systemd' : {
        include 'systemd'
        ::systemd::unit_file {'prometheus.service':
          content => template('prometheus/prometheus.systemd.erb'),
        }
      }
      'sysv' : {
        file { '/etc/init.d/prometheus':
          mode    => '0555',
          owner   => 'root',
          group   => 'root',
          content => template('prometheus/prometheus.sysv.erb'),
        }
      }
      'debian' : {
        file { '/etc/init.d/prometheus':
          mode    => '0555',
          owner   => 'root',
          group   => 'root',
          content => template('prometheus/prometheus.debian.erb'),
        }
      }
      'sles' : {
        file { '/etc/init.d/prometheus':
          mode    => '0555',
          owner   => 'root',
          group   => 'root',
          content => template('prometheus/prometheus.sles.erb'),
        }
      }
      'launchd' : {
        file { '/Library/LaunchDaemons/io.prometheus.daemon.plist':
          mode    => '0644',
          owner   => 'root',
          group   => 'wheel',
          content => template('prometheus/prometheus.launchd.erb'),
        }
      }
      default : {
        fail("I don't know how to create an init script for style ${prometheus::init_style}")
      }
    }
  }

  if versioncmp($prometheus::version, '2.0.0') >= 0 {
    $cfg_verify_cmd = 'check config'
  } else {
    $cfg_verify_cmd = 'check-config'
  }

  file { 'prometheus.yaml':
    ensure       => present,
    path         => "${prometheus::config_dir}/prometheus.yaml",
    owner        => $prometheus::user,
    group        => $prometheus::group,
    mode         => $prometheus::config_mode,
    notify       => Class['::prometheus::service_reload'],
    content      => template($config_template),
    validate_cmd => "${prometheus::bin_dir}/promtool ${cfg_verify_cmd} %",
  }

}
