require 'puppet'

service = Puppet::Type.type(:service).new(name: 'alert_manager')

Facter.add('prometheus_alert_manager_running') do
  setcode do
    service.provider.status == :running
  end
end
