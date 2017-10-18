require 'spec_helper'

describe 'prometheus::nginx_vts_exporter' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with version specified' do
        let(:params) do
          {
            version: '0.6',
            arch: 'amd64',
            os: 'linux'
          }
        end

        describe 'install correct binary' do
          it { is_expected.to contain_file('/usr/local/bin/nginx-vts-exporter').with('target' => '/opt/nginx-vts-exporter-0.6.linux-amd64/nginx-vts-exporter') }
        end
      end
    end
  end
end
