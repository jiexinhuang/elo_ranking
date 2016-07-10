class GameForm < BaseForm
  attribute :game_type, String
  attribute :home_player_user, String
  attribute :away_player_username, String
  attribute :result, Integer

  def save!
    ProcessGame.new(game).process
  end

  private

  def game
    Game.new(
      game_type: game_type,
      home_player: home_player,
      away_player: away_player,
      result: parsed_result,
    )
  end

  def parsed_result
    result.to_f / 2
  end
  
  def home_player
    home_player_user.player_for(game_type)
  end

  def away_player
    away_player_user.player_for(game_type)
  end

  def away_player_user
    User.find_by_username(away_player_username)
  end
end
