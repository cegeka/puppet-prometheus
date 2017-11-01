Facter.add('prometheus_alert_manager_running') do
  setcode do
    svc_status = Facter::Core::Execution.exec('puppet resource service alert_manager | grep ensure')
    svc_status.split("'")[1]
  end
end
