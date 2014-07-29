require 'spec_helper'
require 'rail/request'

RSpec.describe Rail::Request do
  describe '#path' do
    it 'removes the leading slash' do
      env = { 'PATH_INFO' => '/foo/bar.js' }
      expect(described_class.new(env).path).to eq 'foo/bar.js'
    end

    it 'removes the query string' do
      env = { 'PATH_INFO' => '/foo/bar.js?baz' }
      expect(described_class.new(env).path).to eq 'foo/bar.js'
    end

    it 'appends .html when no extension is given' do
      env = { 'PATH_INFO' => '/foo/bar' }
      expect(described_class.new(env).path).to eq 'foo/bar.html'
    end

    it 'substitutes index.html for /' do
      env = { 'PATH_INFO' => '/' }
      expect(described_class.new(env).path).to eq 'index.html'
    end
  end
end
