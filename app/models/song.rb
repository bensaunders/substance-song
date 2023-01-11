# Model that describes a 'substance song' (e.g. 99 bottles of beer)
class Song < ApplicationRecord
  def recite(start_verse = nil, song_length = nil)
    start_verse ||= starting_amount
    song_length ||= start_verse + 1
    situation = SubstanceSituationFactory.build(start_verse, starting_amount)
    song = Array.new(song_length)
    song.each_index do |index|
      song[index] = verse(situation)
      situation = situation.next_situation
    end.join("\n")
  end

  def verse(situation)
    <<~TEXT
      #{situation.description} of beer on the wall, #{situation.description.downcase} of beer.
      #{situation.action}, #{situation.next_situation.description.downcase} of beer on the wall.
    TEXT
  end

  # A factory for building the appropriate situation
  # for an amount of a substance
  module SubstanceSituationFactory
    def self.build(substance_amount, max)
      case substance_amount
      when 0
        NoSubstance.new(substance_amount, max)
      when 1
        OneSubstance.new(substance_amount, max)
      else
        PlentyOfSubstance.new(substance_amount, max)
      end
    end
  end

  # a class that describes the situation when there are a
  # certain number of containers of a substance available,
  # and you take some action to create a new situation
  class SubstanceSituation
    def initialize(amount, max)
      @amount = amount
      @max = max
    end

    def description
      "#{amount} bottles"
    end

    def action
      'Take one down and pass it around'
    end

    def next_situation
      SubstanceSituationFactory.build(amount - 1, max)
    end

    private

    attr_reader :amount, :max
  end

  PlentyOfSubstance = SubstanceSituation

  # a class for when there's one container left
  class OneSubstance < SubstanceSituation
    def description
      '1 bottle'
    end

    def action
      'Take it down and pass it around'
    end
  end

  # a class for when there are no containers left
  class NoSubstance < SubstanceSituation
    def description
      'No more bottles'
    end

    def action
      'Go to the store and buy some more'
    end

    def next_situation
      SubstanceSituationFactory.build(max, max)
    end
  end
end
