require 'spec_helper_acceptance'

describe 'prometheus server basics' do
  it 'prometheus server via main class works idempotently with no errors' do
    if default[:platform] =~ %r{ubuntu-18.04-amd64}
      pp = "package{'iproute2': ensure => present}"
      apply_manifest(pp, catch_failures: true)
    end
    pp = "class{'prometheus': manage_prometheus_server => true }"

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe service('prometheus') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
  describe port(9090) do
    it { is_expected.to be_listening.with('tcp6') }
  end
  it 'prometheus server via server class works idempotently with no errors' do
    pp = 'include prometheus::server'

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe service('prometheus') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
  describe port(9090) do
    it { is_expected.to be_listening.with('tcp6') }
  end

  describe 'prometheus server with options' do
    it 'is idempotent' do
      pp = "class{'prometheus::server': version => '2.3.2', external_url => '/test'}"
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('prometheus') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe port(9090) do
      it { is_expected.to be_listening.with('tcp6') }
    end
  end
end
