# Controller for assembling a 'substance song' (e.g. 99 bottles of beer)
class SongsController < ApplicationController
  def show
    @song = Song.new
  end
end
