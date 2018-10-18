require 'spec_helper_acceptance'

describe 'prometheus collectd exporter' do
  it 'collectd_exporter works idempotently with no errors' do
    if default[:platform] =~ %r{ubuntu-18.04-amd64}
      pp = "package{'iproute2': ensure => present}"
      apply_manifest(pp, catch_failures: true)
    end
    pp = 'include prometheus::collectd_exporter'
    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe service('collectd_exporter') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
  # the class installs an the collectd_exporter that listens on port 9103
  describe port(9103) do
    it { is_expected.to be_listening.with('tcp6') }
  end
end
