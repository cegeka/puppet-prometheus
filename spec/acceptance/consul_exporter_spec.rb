require 'spec_helper_acceptance'

describe 'prometheus consul exporter' do
  it 'consul_exporter works idempotently with no errors' do
    pp = 'include prometheus::consul_exporter'
    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe 'prometheus consul exporter version 0.3.0' do
    it ' consul_exporter installs with version 0.3.0' do
      pp = "class {'prometheus::consul_exporter': version => '0.3.0' }"
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
    describe process('consul_exporter') do
      its(:args) { is_expected.to match %r{\ -consul.server} }
    end
  end

  describe 'prometheus consul exporter version 0.4.0' do
    it ' consul_exporter installs with version 0.4.0' do
      pp = "class {'prometheus::consul_exporter': version => '0.4.0' }"
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
    describe process('consul_exporter') do
      its(:args) { is_expected.to match %r{\ --consul.server} }
    end
  end
end
