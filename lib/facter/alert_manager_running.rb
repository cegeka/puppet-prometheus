Facter.add('prometheus_alert_manager_running') do
  setcode do
    svc_status = Facter::Core::Execution.exec('puppet resource service alert_manager --to_yaml')
    svc_status['service']['alert_manager']['ensure']
  end
end
