Facter.add('prometheus_alert_manager_running') do
  setcode do
    Facter::Core::Execution.execute('puppet resource service alert_manager 2>&1').scan('running')[0]
  end
end
