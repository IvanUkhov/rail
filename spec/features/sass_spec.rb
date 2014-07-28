require 'spec_helper'
require 'fixtures/project/controller'

RSpec.describe Rail::Application do
  it 'handles uncompressed Sass assests' do
    controller = Controller.new do
      config.compress = false
    end
    body = controller.process('/application.css')
    expect(body.strip).to eq <<-BODY.strip
* {
  margin: 0;
  padding: 0; }

body {
  font-family: 'Benton Modern Display'; }
    BODY
  end

  it 'handles compressed Sass assets' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/application.css')
    expect(body.strip).to eq <<-BODY.strip
*{margin:0;padding:0}body{font-family:'Benton Modern Display'}
    BODY
  end
end
