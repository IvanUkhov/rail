require 'spec_helper'
require 'rail/request'
require 'rail/precompiler'

RSpec.describe Rail::Precompiler do
  let(:pipeline) { double }
  let(:storage) { double }

  subject do
    precompiler = Rail::Precompiler.new(pipeline, storage)
    allow(precompiler).to receive(:report)
    precompiler
  end

  describe '#process' do
    it 'works' do
      expect(pipeline).to \
        receive(:process).and_return([200, {}, ['Hello, world!']])
      expect(storage).to \
        receive(:write).with('index.html', ['Hello, world!'])

      subject.process(['index.html'])
    end
  end
end
