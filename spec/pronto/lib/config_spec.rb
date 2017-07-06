require 'spec_helper'

RSpec.describe Pronto::CircleCI::Config do
  subject { described_class.clone.instance }
  before(:example) do
    allow(YAML).to receive(:load_file) do
      {
        'one' => 'level',
        'three' => {
          'two' => {
            'one' => 'levels'
          }
        }
      }
    end
  end

  describe '#get' do
    it 'returns a one level config value' do
      expect(subject.get('one')).to eq('level')
    end

    it 'returns a three level config value' do
      expect(subject.get('three', 'two', 'one')).to eq('levels')
    end
  end
end
