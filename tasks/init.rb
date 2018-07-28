#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'
require 'puppet/face'
require 'json'

params = JSON.parse(STDIN.read)

begin
  Puppet.initialize_settings
  # Check this is the Puppet master/MoM
  raise RuntimeError, 'This can only be run on the Puppet master/MoM' unless Puppet.settings[:server] == Puppet[:certname]
  # Purge node
  output = Puppet::Face[:node,:current].purge(params['certname'])
  puts "Node #{output[0]} purged"
rescue StandardError => e
  raise "Could not purge certificate: #{e.message}"
end
