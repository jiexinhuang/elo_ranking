class User < ApplicationRecord
  has_many :players
  def player_for(game_type)
    players.where(game_type: game_type).first
  end
end
