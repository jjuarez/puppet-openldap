require 'spec_helper'

describe 'openldap' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:node) { 'ldapmaster-pro-1.fon.ofi' }
        let(:facts) do
          facts
        end

        context "openldap::config class without any parameters" do
          let(:params) do
            { 'slave' => false }
          end

          describe 'openldap::config' do
            it { is_expected.to contain_class('openldap::config').that_notifies('Class[openldap::service]') }

            it do
              is_expected.to contain_file('System config file').with(
                'ensure' =>'present',
                'path'   =>'/etc/sysconfig/slapd',
                'owner'  =>'root',
                'group'  =>'root',
              )
            end

            it do
              is_expected.to contain_file('Main config file').with(
                'ensure' =>'present',
                'path'   =>'/etc/openldap/slapd.conf',
                'owner'  =>'ldap',
                'group'  =>'ldap',
              )
            end
          end
        end

        context "openldap::config class with slave parameter" do
          let(:params) do
            { 'slave' => true }
          end

          describe 'openldap::config' do
            it do
              is_expected.to contain_file('Replication config file').with(
                'ensure' =>'present',
                'path'   =>'/etc/openldap/slave.conf',
                'owner'  =>'ldap',
                'group'  =>'ldap',
              )
            end
          end
        end
      end
    end
  end
end

