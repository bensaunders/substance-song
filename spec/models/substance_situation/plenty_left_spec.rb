require 'rails_helper'

RSpec.describe SubstanceSituation::PlentyLeft, type: :model do
  let(:situation) do
    SubstanceSituation::PlentyLeft.new(Song.new, 28)
  end

  describe '#description' do
    it 'describes the situation using the amount and the container' do
      expect(situation.description).to eql('28 bottles')
    end
  end
end
