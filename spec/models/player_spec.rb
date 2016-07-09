require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { is_expected.to validate_presence_of :game_type }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :rating }

  describe '#games' do
    let(:player1) { Player.create(game_type: 'fifa', user_id: 1, rating: 1000) }
    let(:player2) { Player.create(game_type: 'fifa', user_id: 2, rating: 1000) }
    let(:player3) { Player.create(game_type: 'fifa', user_id: 3, rating: 1000) }
    let!(:game1) { Game.create(game_type: 'fifa', home_player: player1, away_player: player2, result: 1) }
    let!(:game2) { Game.create(game_type: 'fifa', home_player: player2, away_player: player1, result: 1) }
    let!(:game3) { Game.create(game_type: 'fifa', home_player: player1, away_player: player3, result: 1) }
    let!(:game4) { Game.create(game_type: 'fifa', home_player: player3, away_player: player2, result: 1) }

    it 'returns all games played as either home player or away player' do
      expect(player1.games).to eq [game1, game2, game3]
      expect(player2.games).to eq [game1, game2, game4]
      expect(player3.games).to eq [game3, game4]
    end
  end

  describe '#starter?' do
    subject(:player) { Player.create(game_type: 'fifa', user_id: 1, rating: 1000) }
    let(:starter_games_boundary) { 10 }

    before do
      allow(Game).to receive(:where).and_return(double(count: games_count))
      allow(Elo).to receive(:config).and_return(double(starter_games_boundary: starter_games_boundary))
    end

    context 'when player played games less than starter boundary' do
      let(:games_count) { 9 }
      it { is_expected.to be_starter }
    end

    context 'when player played games equal to starter boundary' do
      let(:games_count) { 10 }
      it { is_expected.not_to be_starter }
    end

    context 'when player played games more than starter boundary' do
      let(:games_count) { 11 }
      it { is_expected.not_to be_starter }
    end
  end
end
