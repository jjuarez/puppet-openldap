require 'spec_helper'

describe 'openldap' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:node) { 'ldapmaster-pro-1.fon.ofi' }
        let(:facts) do
          facts
        end

        context "openldap class without any parameters" do
          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end
end

