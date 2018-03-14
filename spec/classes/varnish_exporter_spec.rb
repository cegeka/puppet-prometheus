require 'spec_helper'

describe 'prometheus::varnish_exporter' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with version specified' do
        let(:params) do
          {
            version: '1.4',
            arch: 'amd64',
            os: 'linux'
          }
        end

        describe 'install correct binary' do
          it { is_expected.to contain_file('/usr/local/bin/prometheus_varnish_exporter').with('target' => '/opt/prometheus_varnish_exporter-1.4.linux-amd64/prometheus_varnish_exporter') }
        end
        describe 'required resources' do
          it { is_expected.to contain_group('varnish') }
          it { is_expected.to contain_prometheus__daemon('prometheus_varnish_exporter') }
          it { is_expected.to contain_service('prometheus_varnish_exporter') }
          it { is_expected.to contain_user('varnish_exporter') }
        end
      end
    end
  end
end
