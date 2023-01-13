class SubstanceSituation
  # a class for when there are no containers left
  class NoneLeft < SubstanceSituation
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
end
