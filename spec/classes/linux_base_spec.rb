# frozen_string_literal: true

require 'spec_helper'

describe 'role::linux_base' do
  on_supported_os.each do |os, os_facts|
    next if os_facts[:os]['family'] == 'windows'
    context "on #{os}" do
      let(:facts) { os_facts }

      # Provide user_list as a parameter to avoid Hiera lookup and eyaml errors
      let(:pre_condition) do
        <<-PUPPET
          class { 'profile::linux_user':
            user_list => {},
          }
        PUPPET
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
