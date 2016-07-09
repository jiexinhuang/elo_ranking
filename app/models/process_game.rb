class ProcessGame
  def initialize(game)
    @game = game
  end

  def process
    game.transaction do
      game.save!
      update_home_player_rating
      update_away_player_rating
    end
  end

  private
  
  attr_reader :game
  delegate :home_player, :away_player, :result_gap, to: :game

  def update_home_player_rating
    home_player.update_attributes!(rating: home_player.rating + (home_player.k_factor * result_gap).round)
  end

  def update_away_player_rating
    away_player.update_attributes!(rating: away_player.rating - (away_player.k_factor * result_gap).round)
  end
end
