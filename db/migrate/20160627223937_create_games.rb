class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string  :game_type
      t.integer :home_player_id
      t.integer :away_player_id
      t.float   :result

      t.timestamps
    end
  end
end
