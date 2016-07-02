class Player < ApplicationRecord
  has_many :home_games, class_name: 'Game', foreign_key: :home_player_id
  has_many :away_games, class_name: 'Game', foreign_key: :away_player_id

  validates :game_type, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true
end
