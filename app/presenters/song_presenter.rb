# Presentation methods for the Song class
class SongPresenter < SimpleDelegator
  def recite(start_verse = nil, song_length = nil)
    lyrics(start_verse, song_length).map do |verse_lines|
      verse_lines.join("\n")
    end.join("\n\n")
  end

  def name
    situation = SubstanceSituation.build(self, starting_amount)
    "#{situation.description} of #{substance} #{location}"
  end
end
