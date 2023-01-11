class AddSubstanceDetailsToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :substance, :text
    add_column :songs, :location, :text
  end
end
