require 'rails_helper'

RSpec.describe ProcessGame, :type => :model do
  subject(:process_game) { ProcessGame.new(game) }
  let(:ronaldo) { User.create(username: 'ronaldo') }
  let(:messi) { User.create(username: 'messi') }
  let(:player1) { Player.create(game_type: 'fifa', user: ronaldo, rating: 1000) }
  let(:player2) { Player.create(game_type: 'fifa', user: messi, rating: 1000) }

  describe '#process' do
    let(:game) { Game.new(game_type: 'fifa', home_player: player1, away_player: player2, result: 1) }
    it 'saves the game' do
      expect { process_game.process }.to change(Game, :count).by(1)
    end

    it 'updates home player rating' do
      expect { process_game.process }.to change(player1, :rating).by(13)
    end

    it 'updates away player rating' do
      expect { process_game.process }.to change(player1, :rating).by(13)
    end
  end
end
