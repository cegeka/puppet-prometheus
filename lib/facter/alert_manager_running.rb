Facter.add('prometheus_alert_manager_running') do
  setcode do
    Facter::Core::Execution.exec('puppet resource service alert_manager').scan('running')[0]
  end
end
