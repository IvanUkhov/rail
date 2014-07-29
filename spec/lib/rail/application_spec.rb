require 'spec_helper'
require 'fixtures/project/config/application'

RSpec.describe Rail::Application do
  subject { Project::Application.new }

  describe '#call' do
    context 'when index.html exists' do
      before do
        allow(File).to receive(:exist?).and_return(true)
      end

      ['/', '/index.html'].each do |path|
        it "lets the browser serve #{path}" do
          expect(subject.browser).to receive(:process)
          expect(subject.pipeline).not_to receive(:process)

          subject.call('PATH_INFO' => path)
        end
      end
    end

    context 'when index.html does not exist' do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end

      ['/', '/index.html'].each do |path|
        it "lets the pipeline serve #{path}" do
          expect(subject.browser).not_to receive(:process)
          expect(subject.pipeline).to receive(:process)

          subject.call('PATH_INFO' => path)
        end
      end
    end
  end
end
