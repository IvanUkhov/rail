require 'spec_helper'

describe Rail::Configuration do
  subject { Rail::Configuration.new(first: 1, second: 2) }

  describe '#new' do
    it 'assigns attributes according to the given options' do
      assert subject.first == 1
      assert subject.second == 2
    end
  end

  it 'permits reading arbitrary attributes' do
    assert subject.fourty_second == nil
  end

  it 'permits writing arbitrary attributes' do
    subject.fourty_second = 42
    assert subject.fourty_second == 42
  end

  it 'permits querying arbitrary attributes' do
    assert subject.fourty_second? === false
    subject.fourty_second = 42
    assert subject.fourty_second? === true
  end

  describe '#merge' do
    it 'returns a new instance' do
      another = subject.merge(fourty_second: 42)
      assert another.is_a?(Rail::Configuration)
      assert another.object_id != subject.object_id
    end

    it 'combines the existing attributes with the given options' do
      another = subject.merge(fourty_second: 42)
      assert another.first == 1
      assert another.second == 2
      assert another.fourty_second == 42
    end
  end
end
