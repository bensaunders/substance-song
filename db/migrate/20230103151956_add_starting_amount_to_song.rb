class AddStartingAmountToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :starting_amount, :integer
  end
end
