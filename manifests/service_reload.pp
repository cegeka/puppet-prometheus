# This class implements prometheus service reload
# without restarting the whole service when a config
# changes
class prometheus::service_reload() {

  if $prometheus::manage_service == true {
    $init_selector = $prometheus::run_service::init_selector

    $prometheus_reload = $prometheus::init_style ? {
      'systemd' => "systemctl reload ${init_selector}",
      'upstart' => "service ${init_selector} reload",
      'sysv'    => "/etc/init.d/${init_selector} reload",
      'sles'    => "/etc/init.d/${init_selector} reload",
      'debian'  => "/etc/init.d/${init_selector} reload",
      'launchd' => "launchctl stop ${init_selector} && launchctl start ${init_selector}",
    }

    exec { 'prometheus-reload':
      command     => $prometheus_reload,
      path        => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ],
      refreshonly => true,
    }
  }
}
