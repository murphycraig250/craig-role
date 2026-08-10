# frozen_string_literal: true

require 'spec_helper'

describe 'role::windows_base' do
  on_supported_os.each do |os, os_facts|
    next unless os_facts[:os]['family'] == 'windows'
    # Skip Windows catalog compilation on non-Windows test hosts (like Linux CI)
    # because Windows-specific providers (e.g. windows_adsi, powershell) require Windows.
    next if !Gem.win_platform?

    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
