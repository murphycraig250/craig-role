Facter.add(:lab_role) do
  setcode do
    hostname = Facter.value(:hostname).downcase

    case hostname
    when /^dc\d+/
      'dc'
    when /^w\d+/
      'client'
    when /^srv\d+/
      'server'
    else
      'unknown'
    end
  end
end