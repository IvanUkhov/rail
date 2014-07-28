require 'spec_helper'
require 'rail/generator'

RSpec.describe Rail::Generator do
  let(:destination) { 'project' }
  subject { Rail::Generator.new(destination: destination) }

  describe '#run' do
    it 'raises an exception if the destination folder already exists' do
      expect(File).to receive(:directory?).and_return(true)
      expect { subject.run }.to raise_error(ArgumentError)
    end
  end
end
