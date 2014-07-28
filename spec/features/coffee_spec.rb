require 'spec_helper'
require 'fixtures/project/controller'

RSpec.describe Rail::Application do
  it 'handles uncompressed CoffeeScript assets' do
    controller = Controller.new do
      config.compress = false
    end
    body = controller.process('/application.js')
    expect(body.strip).to eq <<-BODY.strip
(function() {
  window.Parser = (function() {
    function Parser(format) {
      this.format = format;
    }

    return Parser;

  })();

}).call(this);
(function() {
  window.Font = (function() {
    function Font(name) {
      this.name = name;
    }

    return Font;

  })();

}).call(this);
(function() {
  var font;

  font = new Font('Benton Modern Display');

}).call(this);
    BODY
  end

  it 'handles compressed CoffeeScript assets' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/application.js')
    expect(body.strip).to eq <<-BODY.strip
(function(){window.Parser=function(){function n(n){this.format=n}return n}()}).call(this),function(){window.Font=function(){function n(n){this.name=n}return n}()}.call(this),function(){var n;n=new Font(\"Benton Modern Display\")}.call(this);
    BODY
  end
end
