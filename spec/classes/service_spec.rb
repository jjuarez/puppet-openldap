require 'spec_helper'

describe 'openldap' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:node) { 'ldapmaster-pro-1.fon.ofi' }
        let(:facts) do
          facts
        end

        context "openldap::service class without any parameters" do
          describe 'openldap::service' do
            it { is_expected.to contain_service('slapd') }

            it do
              is_expected.to contain_service('slapd').with(
                'ensure'     =>'running',
                'enable'     =>'true',
                'hasstatus'  =>'true',
                'hasrestart' =>'true',
              )
            end
          end
        end
      end
    end
  end
end

