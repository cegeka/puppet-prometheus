Facter.add('prometheus_alert_manager_running') do
  setcode do
    begin
      Facter::Core::Execution.execute('puppet resource service alert_manager').scan('running')[0]
    rescue Facter::Core::Execution::ExecutionFailure
      'not installed'
    end
  end
end
