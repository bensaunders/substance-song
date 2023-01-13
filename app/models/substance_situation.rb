# a class that describes the situation when there are a
# certain number of containers of a substance available,
# and you take some action to create a new situation
class SubstanceSituation
  include ActionView::Helpers::TextHelper

  def self.build(song, substance_amount)
    case substance_amount
    when 0
      NoneLeft.new(song, substance_amount)
    when 1
      OneLeft.new(song, substance_amount)
    else
      PlentyLeft.new(song, substance_amount)
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
