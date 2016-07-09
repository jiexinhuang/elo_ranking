require 'rails_helper'

RSpec.describe 'Test with lots of games', :type => :model do
  let(:ronaldo) { User.create(username: 'ronaldo') }
  let(:messi) { User.create(username: 'messi') }
  let(:player1) { Player.create(game_type: 'fifa', user: ronaldo, rating: 1000) }
  let(:player2) { Player.create(game_type: 'fifa', user: messi, rating: 1000) }

  it 'create 100 games with random results' do
    create_random_games(100)

    expect(player1.games.count).to eq 100
    expect(player2.games.count).to eq 100
    expect(player1.rating + player2.rating).to eq 2000
  end

  it 'create 100 games with random results for two pro players' do
    player1.update_attributes!(rating: 2600, pro: true)
    player2.update_attributes!(rating: 3400, pro: true)
    create_random_games(100)
    expect(player1.rating + player2.rating).to eq 6000
  end
end

def create_random_games(number_of_games)
  results = [0.0, 0.5, 1.0]
  number_of_games.times do
    result = results.shuffle!.first
    game = Game.new(game_type: 'fifa', home_player: player1, away_player: player2, result: result)
    ProcessGame.new(game).process
  end
end
