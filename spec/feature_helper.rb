require 'rspec/bdd'
require 'fixtures/project/controller'

RSpec.shared_context 'Clean setup', bdd: true do
  around do |example|
    config = Project::Application.instance_variable_get(:@config).dup
    example.call
    Project::Application.instance_variable_set(:@config, config)
  end
end
