require 'rails_helper'

RSpec.describe SubstanceSituation, type: :model do
  let(:song) { Song.new }

  describe '#build' do
    it 'builds a "plenty" situation for most amounts' do
      [99, 2, 1000, 54].each do |normal_amount|
        expect(SubstanceSituation.build(song, normal_amount)).to be_a(PlentyOfSubstance)
      end
    end

    it 'builds a "one" situation for an amount of 1' do
      expect(SubstanceSituation.build(song, 1)).to be_a(OneSubstance)
    end

    it 'builds a "none" situation for an amount of 0' do
      expect(SubstanceSituation.build(song, 0)).to be_a(NoSubstance)
    end
  end
end
