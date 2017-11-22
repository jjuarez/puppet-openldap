require 'spec_helper'

describe 'openldap' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:node) { 'ldapmaster-pro-1.fon.ofi' }
        let(:facts) do
          facts
        end

        context "openldap::install class without any parameters" do
          describe 'openldap::install' do
            it { is_expected.to contain_class('openldap::install').that_comes_before('Class[openldap::config]') }
            it { is_expected.to contain_package('openldap-servers').with_ensure('installed') }
          end
        end
      end
    end
  end
end

