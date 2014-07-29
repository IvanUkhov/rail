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
end
