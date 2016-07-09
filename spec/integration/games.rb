require 'rails_helper'

RSpec.describe 'Test with lots of games', :type => :model do
  let(:player1) { Player.create(game_type: 'fifa', user_id: 1, rating: 1000) }
  let(:player2) { Player.create(game_type: 'fifa', user_id: 2, rating: 1000) }

  it 'create 100 games with random results' do
    results = [0.0, 0.5, 1.0]
    100.times do
      result = results.shuffle!.first
      game = Game.new(game_type: 'fifa', home_player: player1, away_player: player2, result: result)
      ProcessGame.new(game).process
    end

    expect(player1.games.count).to eq 100
    expect(player2.games.count).to eq 100
    expect(player1.rating + player2.rating).to eq 2000
  end
end
