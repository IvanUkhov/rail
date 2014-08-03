require 'support/inflector'

RSpec.describe Support::Inflector do
  describe '.titelize' do
    {
      " \t  pro ject \n" => 'Pro Ject',
      '42_my project' => 'My Project',
      'project42' => 'Project42',
      'project   42' => 'Project 42',
      'project___  42nd' => 'Project 42nd',
      'PRO ject' => 'PRO Ject',
    }.each_pair do |input, output|
      it "converts '#{input}' into '#{output}'" do
        expect(described_class.titelize(input)).to eq output
      end
    end
  end

  describe '.underscorize' do
    {
      'PROActive' => 'proactive',
      'ActivePassive' => 'active_passive',
      'Active::Passive' => 'active_passive',
      'Active::MediumPassive' => 'active_medium_passive',
    }.each_pair do |input, output|
      it "converts '#{input}' into '#{output}'" do
        expect(described_class.underscorize(input)).to eq output
      end
    end
  end
end
