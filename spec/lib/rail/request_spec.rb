require 'spec_helper'
require 'rail/request'

RSpec.describe Rail::Request do
  describe '#path' do
    it 'appends .html when no extension is given' do
      env = { 'PATH_INFO' => '/foo/bar' }
      expect(described_class.new(env).path).to eq '/foo/bar.html'
    end

    it 'substitutes /index.html for /' do
      env = { 'PATH_INFO' => '/' }
      expect(described_class.new(env).path).to eq '/index.html'
    end
  end
end
