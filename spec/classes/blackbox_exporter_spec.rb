require 'spec_helper'

describe 'prometheus::blackbox_exporter' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with version specified' do
        let(:params) do
          {
            version: '0.6.0',
            arch: 'amd64',
            os: 'linux',
            modules: {
              'http_2xx' => {
                'prober' => 'http'
              }
            }
          }
        end

        describe 'install correct binary' do
          it { is_expected.to contain_file('/usr/local/bin/blackbox_exporter').with('target' => '/opt/blackbox_exporter-0.6.0.linux-amd64/blackbox_exporter') }
        end
        describe 'config file contents' do
          it {
            is_expected.to contain_file('/etc/blackbox-exporter.yaml')
            verify_contents(catalogue, '/etc/blackbox-exporter.yaml', ['---', 'modules:', '  http_2xx:', '    prober: http'])
          }
        end
      end
    end
  end
end
