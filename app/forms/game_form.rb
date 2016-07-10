class GameForm < BaseForm
  attribute :away_player_username, String
  attribute :result, String
  attribute :game_type, String

  def save!
  end
end
