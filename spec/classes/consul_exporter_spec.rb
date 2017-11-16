require 'spec_helper'

describe 'prometheus::consul_exporter' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with version specified' do
        let(:params) do
          {
            version: '0.3.0',
            arch: 'amd64',
            os: 'linux'
          }
        end

        describe 'with all defaults' do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_file('/usr/local/bin/consul_exporter').with('target' => '/opt/consul_exporter-0.3.0.linux-amd64/consul_exporter') }
          it { is_expected.to contain_prometheus__daemon('consul_exporter') }
          it { is_expected.to contain_user('consul-exporter') }
          it { is_expected.to contain_group('consul-exporter') }
          it { is_expected.to contain_service('consul_exporter') }
        end
      end
    end
  end
end
