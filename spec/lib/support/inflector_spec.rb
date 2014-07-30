require 'support/inflector'

RSpec.describe Support::Inflector do
  describe '.titelize' do
    it 'returns pretty strings' do
      { " \t  pro ject \n" => 'Pro Ject',
        '42_my project' => 'My Project',
        'project42' => 'Project42',
        'project   42' => 'Project 42',
        'project___  42nd' => 'Project 42nd',
        'PRO ject' => 'PRO Ject'
      }.each_pair do |input, output|
        expect(described_class.titelize(input)).to eq output
      end
    end
  end
end
