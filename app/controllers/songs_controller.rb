# Controller for assembling a 'substance song' (e.g. 99 bottles of beer)
class SongsController < ApplicationController
  def index
    @songs = Song.all.map(&:decorate)
  end

  def show
    song = Song.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: '404 Not Found', status: :not_found
  else
    @lyrics = song.decorate.recite(*recite_params(params))
  end

  private

  def recite_params(params)
    [
      params[:start_verse] ? params[:start_verse].to_i : nil,
      params[:song_length] ? params[:song_length].to_i : nil
    ]
  end
end
