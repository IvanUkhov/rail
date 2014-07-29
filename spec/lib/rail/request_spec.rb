require 'spec_helper'
require 'rail/request'

RSpec.describe Rail::Request do
  describe '#path' do
    it 'returns the path without the leading slash' do
      env = { 'PATH_INFO' => '/foo/bar' }
      expect(described_class.new(env).path).to eq 'foo/bar'

      env = { 'PATH_INFO' => '/' }
      expect(described_class.new(env).path).to eq ''
    end

    it 'returns the path without the query string' do
      env = { 'PATH_INFO' => '/foo/bar?baz' }
      expect(described_class.new(env).path).to eq 'foo/bar'

      env = { 'PATH_INFO' => '/?baz' }
      expect(described_class.new(env).path).to eq ''
    end
  end
end
