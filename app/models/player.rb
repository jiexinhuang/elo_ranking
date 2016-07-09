class Player < ApplicationRecord
  validates :game_type, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true

  def games
    Game.where("`home_player_id` = #{id} OR `away_player_id` = #{id}")
  end

end
