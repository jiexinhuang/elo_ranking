class Player < ApplicationRecord
  validates :game_type, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true

  def games
    Game.where("`home_player_id` = #{id} OR `away_player_id` = #{id}")
  end

  def starter?
    games.count < starter_games_boundary
  end

  def k_factor
    if pro?
      pro_k_factor
    elsif starter?
      starter_k_factor
    else
      default_k_factor
    end
  end

  def update_rating(diff)
    self.rating = rating + diff
    if rating >= pro_rating_boundary
      self.pro = true
    end
    self.save!
  end

  private

  delegate :starter_games_boundary, :default_k_factor, :starter_k_factor, :pro_k_factor, :pro_rating_boundary,
    to: :config

  def config
    Elo.config
  end
end
