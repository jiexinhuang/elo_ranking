class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :game_type
      t.integer :user_id
      t.integer :rating
      t.boolean :pro

      t.timestamps
    end
  end
end
