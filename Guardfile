guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^lib/(.+)\.rb$}) do |match|
    file = "spec/lib/#{match[1]}_spec.rb"
    File.exist?(file) ? file : 'spec'
  end
  watch(%r{^spec/.*_spec\.rb$})
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
end

# vim: set ft=ruby
