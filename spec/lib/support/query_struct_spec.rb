require 'spec_helper'
require 'support/query_struct'

RSpec.describe Support::QueryStruct do
  subject { described_class.new(first: 1, second: 2) }

  describe '#new' do
    it 'assigns attributes according to the given options' do
      expect(subject.first).to eq 1
      expect(subject.second).to eq 2
    end
  end

  it 'permits reading arbitrary attributes' do
    expect(subject.fourty_second).to be nil
  end

  it 'permits writing arbitrary attributes' do
    subject.fourty_second = 42
    expect(subject.fourty_second).to eq 42
  end

  it 'permits querying arbitrary attributes' do
    expect(subject.fourty_second?).to be false
    subject.fourty_second = 42
    expect(subject.fourty_second?).to be true
  end

  describe '#merge' do
    it 'returns a new instance' do
      another = subject.merge(fourty_second: 42)
      expect(another).to be_kind_of(described_class)
      expect(another).not_to be subject
    end

    it 'combines the existing attributes with the given options' do
      another = subject.merge(fourty_second: 42)
      expect(another.first).to eq 1
      expect(another.second).to eq 2
      expect(another.fourty_second).to eq 42
    end
  end
end
