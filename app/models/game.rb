class Game < ApplicationRecord
  belongs_to :home_player, class_name: 'Player', foreign_key: :home_player_id
  belongs_to :away_player, class_name: 'Player', foreign_key: :away_player_id

  validates :game_type, presence: true
  validates :result, presence: true
  validates :home_player, presence: true
  validates :away_player, presence: true

  # See http://en.wikipedia.org/wiki/Elo_rating_system#Mathematical_details for more details
  def expected_result
    @expected_result ||= 1.0 / ( 1.0 + 10.0 ** relative_rating_gap)
  end

  def result_gap
    result - expected_result
  end

  private

  # TODO: Rename this constant
  RATING_CONST = 400.0

  def relative_rating_gap
    rating_gap / RATING_CONST
  end

  def rating_gap
    away_player.rating - home_player.rating
  end
end
