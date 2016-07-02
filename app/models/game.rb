class Game < ApplicationRecord
  belongs_to :home_player, class_name: 'Player', foreign_key: :home_player_id
  belongs_to :away_player, class_name: 'Player', foreign_key: :away_player_id

  validates :game_type, presence: true
  validates :result, presence: true
  validates :home_player, presence: true
  validates :away_player, presence: true
end
