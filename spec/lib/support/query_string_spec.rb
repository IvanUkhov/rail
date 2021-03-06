require 'spec_helper'
require 'support/query_string'

RSpec.describe Support::QueryString do
  subject { described_class.new('hello') }

  it 'permits querying' do
    expect(subject.hello?).to be true
    expect(subject.goodbye?).to be false
  end
end
