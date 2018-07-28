#!/opt/puppetlabs/puppet/bin/ruby
require 'open3'
require 'json'

params = JSON.parse(STDIN.read)

begin
  cmd_string = "/opt/puppetlabs/bin/puppet node purge #{params['certname']}"
  stdout, _stderr, status = Open3.capture3(cmd_string)
  puts stdout unless status != 0
rescue => e
  raise "Could not purge certificate: #{e}"
end
