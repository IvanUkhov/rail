require 'spec_helper'
require 'support/loader'

RSpec.describe Support::Loader do
  let(:pattern) { File.join(fixture_path, 'project/app/helpers/*.rb') }
  subject { described_class.new(pattern) }

  before do
    if Object.const_defined?(:ApplicationHelper)
      Object.send(:remove_const, :ApplicationHelper)
    end
  end

  describe '#find' do
    it 'loads and returns modules' do
      result = subject.find
      expect(result).to eq [ApplicationHelper]
    end

    it 'does not reload modules if they have not unchanged' do
      expect(subject.reload?).to be true

      subject.find

      expect(subject.reload?).to be false
    end

    it 'reloads modules if they have changed' do
      expect(subject.reload?).to be true

      subject.find

      expect(File).to receive(:mtime).and_return(Time.now)
      expect(subject.reload?).to be true
    end
  end
end
