# Model that describes a 'substance song' (e.g. 99 bottles of beer)
class Song < ApplicationRecord
  attribute :starting_amount, default: 99
  attribute :substance, default: 'beer'
  attribute :location, default: 'on the wall'
  attribute :container, default: 'bottle'

  def lyrics(start_verse = nil, song_length = nil)
    start_verse ||= starting_amount
    song_length ||= start_verse + 1
    situation = SubstanceSituationFactory.build(self, start_verse)
    lyrics = Array.new(song_length)
    lyrics.each_index do |index|
      lyrics[index] = verse(situation)
      situation = situation.next_situation
    end
  end

  def recite(start_verse = nil, song_length = nil)
    lyrics(start_verse, song_length).map do |verse_lines|
      verse_lines.join("\n")
    end.join("\n\n")
  end

  def verse(situation)
    [
      "#{situation.description} of #{substance} #{location}, #{situation.description.downcase} of #{substance}.",
      "#{situation.action}, #{situation.next_situation.description.downcase} of #{substance} #{location}."
    ]
  end

  # A factory for building the appropriate situation
  # for an amount of a substance
  module SubstanceSituationFactory
    def self.build(song, substance_amount)
      case substance_amount
      when 0
        NoSubstance.new(song, substance_amount)
      when 1
        OneSubstance.new(song, substance_amount)
      else
        PlentyOfSubstance.new(song, substance_amount)
      end
    end
  end

  # a class that describes the situation when there are a
  # certain number of containers of a substance available,
  # and you take some action to create a new situation
  class SubstanceSituation
    include ActionView::Helpers::TextHelper

    def initialize(song, amount)
      @song = song
      @amount = amount
    end

    def description
      pluralize(amount, song.container)
    end

    def action
      'Take one down and pass it around'
    end

    def next_situation
      SubstanceSituationFactory.build(song, amount - 1)
    end

    private

    attr_reader :amount, :song
  end

  PlentyOfSubstance = SubstanceSituation

  # a class for when there's one container left
  class OneSubstance < SubstanceSituation
    def action
      'Take it down and pass it around'
    end
  end

  # a class for when there are no containers left
  class NoSubstance < SubstanceSituation
    def description
      "No more #{song.container.pluralize(amount)}"
    end

    def action
      'Go to the store and buy some more'
    end

    def next_situation
      SubstanceSituationFactory.build(song, song.starting_amount)
    end
  end
end
