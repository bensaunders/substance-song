require 'rails_helper'

RSpec.describe SubstanceSituation::OneLeft do
  let(:situation) do
    SubstanceSituation::OneLeft.new(Song.new, 1)
  end

  describe '#description' do
    it 'uses the singular container name' do
      expect(situation.description).to eql('1 bottle')
    end
  end
end
