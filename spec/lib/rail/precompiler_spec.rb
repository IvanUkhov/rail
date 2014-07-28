require 'spec_helper'

describe Rail::Precompiler do
  let(:pipeline) { MiniTest::Mock.new }
  let(:storage) { MiniTest::Mock.new }
  let(:logger) { Class.new { def write(*) end }.new }

  subject { Rail::Precompiler.new(pipeline, storage: storage, logger: logger) }

  describe '#process' do
    it 'works' do
      pipeline.expect(:process, [200, {}, ['Hello, world!']], [Rail::Request])
      storage.expect(:write, nil, ['index.html', ['Hello, world!']])

      subject.process(['index.html'])

      pipeline.verify
      storage.verify
    end
  end
end