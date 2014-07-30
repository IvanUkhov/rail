require 'support/loader'

RSpec.describe Support::Loader do
  before do
    if Object.const_defined?(:ApplicationHelper)
      Object.send(:remove_const, :ApplicationHelper)
    end
  end

  subject { described_class.new(pattern) }

  describe '#find' do
    context 'there are files to process' do
      let(:pattern) { File.join(fixture_path, 'project/app/helpers/*.rb') }

      it 'loads and returns modules' do
        expect(Object.const_defined?(:ApplicationHelper)).to be false

        result = subject.find

        expect(Object.const_defined?(:ApplicationHelper)).to be true
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

    context 'there are no files to process' do
      let(:pattern) { File.join(fixture_path, 'project/app/helpers/*.br') }

      it 'returns an empty array' do
        expect(subject.find).to be_empty
      end

      it 'does not load/reload anything' do
        expect(subject.reload?).to be true

        subject.find

        allow(File).to receive(:mtime).and_return(Time.now)
        expect(subject.reload?).to be false
      end
    end
  end
end
