# Controller for assembling a 'substance song' (e.g. 99 bottles of beer)
class SongsController < ApplicationController
  def show
    @lyrics = Song.new(starting_amount: 99).recite(*recite_params(params))
  end

  private

  def recite_params(params)
    [
      params[:start_verse] ? params[:start_verse].to_i : nil,
      params[:song_length] ? params[:song_length].to_i : nil
    ]
  end
end
