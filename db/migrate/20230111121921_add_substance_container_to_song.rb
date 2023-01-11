class AddSubstanceContainerToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :container, :text
  end
end
