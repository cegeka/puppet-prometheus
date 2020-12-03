def os_specific_facts(facts)
  if ['Archlinux', 'Debian', 'RedHat'].include?(facts[:os]['family'])
    { service_provider: 'systemd' }
  end
end
