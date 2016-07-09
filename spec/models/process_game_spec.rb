require 'rails_helper'

RSpec.describe ProcessGame, :type => :model do
  subject(:process_game) { ProcessGame.new(game) }
  let(:player1) { Player.create(game_type: 'fifa', user_id: 1, rating: 1000) }
  let(:player2) { Player.create(game_type: 'fifa', user_id: 2, rating: 1000) }

  describe '#process' do
    context 'when game is already persisted' do
      let(:game) { Game.create(game_type: 'fifa', home_player: player1, away_player: player2, result: 1) }
      it 'raises exception about game already saved' do
        expect { process_game.process }.to raise_error 'Cannot process already saved game'
      end
    end

    context 'when game is a new record' do
      let(:game) { Game.new(game_type: 'fifa', home_player: player1, away_player: player2, result: 1) }
      it 'save the game' do
        expect { process_game.process }.to change(Game, :count).by(1)
      end
    end
  end
end
