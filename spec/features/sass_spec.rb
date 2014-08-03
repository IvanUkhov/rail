require 'feature_helper'

RSpec.feature 'Handling Sass' do
  scenario 'Serving an ordinary stylesheet' do
    controller = Controller.new
    body = controller.process('/application.css')
    expect(body.strip).to eq <<-BODY.strip
* {
  margin: 0;
  padding: 0; }

body {
  font-family: 'Benton Modern Display'; }
    BODY
  end

  scenario 'Serving a compressed stylesheet' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/application.css')
    expect(body.strip).to eq <<-BODY.strip
*{margin:0;padding:0}body{font-family:'Benton Modern Display'}
    BODY
  end
end
