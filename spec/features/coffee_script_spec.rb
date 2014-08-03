require 'feature_helper'

RSpec.feature 'Handling CoffeeScript' do
  scenario 'Serving an ordinary script' do
    controller = Controller.new
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

  scenario 'Serving a compressed script' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/application.js')
    expect(body.strip).to eq <<-BODY.strip
(function(){window.Parser=function(){function n(n){this.format=n}return n}()}).call(this),function(){window.Font=function(){function n(n){this.name=n}return n}()}.call(this),function(){var n;n=new Font(\"Benton Modern Display\")}.call(this);
    BODY
  end

  scenario 'Serving a script without wrapping it in a closure' do
    controller = Controller.new do
      config.coffee_script.bare = true
    end
    body = controller.process('/application.js')
    expect(body.strip).to eq <<-BODY.strip
window.Parser = (function() {
  function Parser(format) {
    this.format = format;
  }

  return Parser;

})();
window.Font = (function() {
  function Font(name) {
    this.name = name;
  }

  return Font;

})();
var font;

font = new Font('Benton Modern Display');
    BODY
  end
end
