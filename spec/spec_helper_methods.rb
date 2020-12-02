def os_specific_facts(facts)
  case facts[:os]['family']
  when 'Archlinux'
    { service_provider: 'systemd' }
  when 'Debian'
    case facts[:os]['release']['major']
    when '9'
      { service_provider: 'systemd' }
    when '10'
      { service_provider: 'systemd' }
    when '16.04'
      { service_provider: 'systemd' }
    when '18.04'
      { service_provider: 'systemd' }
    end
  when 'RedHat'
    { service_provider: 'systemd' }
  end
end
