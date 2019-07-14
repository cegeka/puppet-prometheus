require 'spec_helper_acceptance'

describe 'prometheus nginx_vts_exporter' do
  it 'nginx_vts_exporter works idempotently with no errors' do
    if default[:platform] =~ %r{ubuntu-18.04-amd64}
      pp = "package{'iproute2': ensure => present}"
      apply_manifest(pp, catch_failures: true)
    end
    pp = 'include prometheus::nginx_vts_exporter'
    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe service('nginx-vts-exporter') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe port(9913) do
    it { is_expected.to be_listening.with('tcp6') }
  end

  describe 'nginx_vts_exporter update from 0.6 to 0.10.3' do
    it 'is idempotent' do
      pp = "class{'prometheus::nginx_vts_exporter': version => '0.6'}"
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('nginx-vts-exporter') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe port(9913) do
      it { is_expected.to be_listening.with('tcp6') }
    end
    it 'is idempotent' do
      pp = "class{'prometheus::nginx_vts_exporter': version => '0.10.3'}"
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('nginx-vts-exporter') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe port(9913) do
      it { is_expected.to be_listening.with('tcp6') }
    end
  end
end
