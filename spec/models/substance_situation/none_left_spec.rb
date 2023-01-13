require 'rails_helper'

RSpec.describe SubstanceSituation::NoneLeft do
  let(:situation) do
    SubstanceSituation::NoneLeft.new(Song.new, 0)
  end

  describe '#description' do
    it 'uses words for the amount' do
      expect(situation.description).to eql('No more bottles')
    end
  end
end
