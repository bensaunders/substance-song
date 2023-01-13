# a class that describes the situation when there are a
# certain number of containers of a substance available,
# and you take some action to create a new situation
class SubstanceSituation
  include ActionView::Helpers::TextHelper

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
    song.build_situation(amount - 1)
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
    song.build_situation(song.starting_amount)
  end
end
