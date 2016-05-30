require 'spec_helper'

describe "prometheus::node_exporter" do

  context 'uses the correct binary path for version < 0.12.0' do
    let(:facts) { {
        'operatingsystem' => 'CentOS',
        'operatingsystemrelease' => '7.0',
        'architecture' => 'amd64',
        'kernel' => 'Linux',
    } }

    let(:params) { {:version => '0.10.0', :arch => 'amd64', :os => 'linux'} }

    it do
      should contain_file('/usr/local/bin/node_exporter').with({
        'target' => '/opt/staging/node_exporter'
      })
    end
  end

  context 'uses the correct binary path for versions >= 0.12' do
    let(:facts) { {
        'operatingsystem' => 'CentOS',
        'operatingsystemrelease' => '7.0',
        'architecture' => 'amd64',
        'kernel' => 'Linux',
    } }

    let(:params) { {:version => '0.12.0', :arch => 'amd64', :os => 'linux'} }

    it do
      should contain_file('/usr/local/bin/node_exporter').with({
        'target' => '/opt/staging/node_exporter-0.12.0.linux-amd64/node_exporter'
      })
    end
  end

end
