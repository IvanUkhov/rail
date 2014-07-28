require 'minitest/autorun'
require 'support/query_string'

describe Support::QueryString do
  subject { Support::QueryString.new('hello') }

  it 'permits querying' do
    assert subject.hello? == true
    assert subject.goodbye? == false
  end
end
