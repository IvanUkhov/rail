require 'feature_helper'

RSpec.feature 'Handling Haml' do
  scenario 'Serving an ordinary template' do
    controller = Controller.new
    body = controller.process('/')
    expect(body.strip).to eq <<-BODY.strip
<!DOCTYPE html>
<html>
  <head>
    <title>Hello</title>
  </head>
  <body>
    <h1>Hello</h1>
  </body>
</html>
    BODY
  end

  scenario 'Serving a compressed template' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/')
    expect(body.strip).to eq <<-BODY.strip
<!DOCTYPE html>
<html>
<head>
<title>Hello</title>
</head>
<body>
<h1>Hello</h1>
</body>
</html>
    BODY
  end

  scenario 'Serving a templates within a layout' do
    controller = Controller.new
    body = controller.process('/articles/about')
    expect(body.strip).to eq <<-BODY.strip
<!DOCTYPE html>
<html>
  <head>
    <title>Hello</title>
  </head>
  <body>
    <h1>About</h1>
  </body>
</html>
    BODY
  end
end
