require 'spec_helper'
require 'fixtures/project/controller'

describe Rail::Application do
  it 'handles uncompressed Haml assets' do
    controller = Controller.new do
      config.compress = false
    end
    body = controller.process('/')
    assert_equal body.strip, <<-BODY.strip
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

  it 'handles compressed Haml assets' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/')
    assert_equal body.strip, <<-BODY.strip
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

  it 'handles layouts' do
    controller = Controller.new do
      config.compress = false
    end
    body = controller.process('/articles/about')
    assert_equal body.strip, <<-BODY.strip
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
