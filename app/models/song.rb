# Model that describes a 'substance song' (e.g. 99 bottles of beer)
class Song < ApplicationRecord
  include Presentable

  attribute :starting_amount, default: 99
  attribute :substance, default: 'beer'
  attribute :location, default: 'on the wall'
  attribute :container, default: 'bottle'

  def lyrics(start_verse = nil, song_length = nil)
    start_verse ||= starting_amount
    song_length ||= start_verse + 1
    situation = build_situation(start_verse)
    lyrics = Array.new(song_length)
    lyrics.each_index do |index|
      lyrics[index] = verse(situation)
      situation = situation.next_situation
    end
  end

  def build_situation(substance_amount)
    substance_amount = starting_amount unless valid_amount?(substance_amount)

    SubstanceSituation.build(self, substance_amount)
  end

  private

  def valid_amount?(amount)
    return false unless amount.is_a?(Integer)
    return false unless amount.between?(0, starting_amount)

    true
  end

  def verse(situation)
    [
      "#{situation.description} of #{substance} #{location}, #{situation.description.downcase} of #{substance}.",
      "#{situation.action}, #{situation.next_situation.description.downcase} of #{substance} #{location}."
    ]
  end
end
